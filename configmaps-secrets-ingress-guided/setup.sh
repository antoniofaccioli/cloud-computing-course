#!/bin/bash
until kubectl get nodes | grep -q "Ready"; do sleep 3; done

kubectl create namespace lesson15

# frontend Deployment + Service
cat > /root/frontend-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: lesson15
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: nginx:alpine
        ports:
        - containerPort: 80
        env:
        - name: APP_ENV
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_ENV
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: LOG_LEVEL
EOF

cat > /root/frontend-service.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: frontend
  namespace: lesson15
spec:
  selector:
    app: frontend
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
EOF

# api Deployment + Service
cat > /root/api-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  namespace: lesson15
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
      - name: api
        image: nginx:alpine
        ports:
        - containerPort: 80
        env:
        - name: DB_HOST
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_HOST
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_PASSWORD
EOF

cat > /root/api-service.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: api
  namespace: lesson15
spec:
  selector:
    app: api
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
EOF

echo "Setup complete."
