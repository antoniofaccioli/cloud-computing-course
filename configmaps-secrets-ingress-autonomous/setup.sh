#!/bin/bash
until kubectl get nodes | grep -q "Ready"; do sleep 3; done

kubectl create namespace lesson15 2>/dev/null || true

# Re-create app-config and db-secret (Exercise A may not have run)
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=LOG_LEVEL=info \
  --from-literal=MAX_CONNECTIONS=100 \
  -n lesson15 2>/dev/null || true

kubectl create secret generic db-secret \
  --from-literal=DB_HOST=postgres.internal \
  --from-literal=DB_PASSWORD=s3cr3tP@ss \
  -n lesson15 2>/dev/null || true

# Deploy frontend
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
kubectl apply -f /root/frontend-deployment.yaml

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
kubectl apply -f /root/frontend-service.yaml

# Deploy api
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
kubectl apply -f /root/api-deployment.yaml

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
kubectl apply -f /root/api-service.yaml

# Install Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/baremetal/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "Setup complete. Ingress Controller ready."
