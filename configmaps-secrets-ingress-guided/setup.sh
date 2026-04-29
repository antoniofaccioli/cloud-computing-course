#!/bin/bash
until kubectl get nodes | grep -q "Ready"; do sleep 3; done

kubectl create namespace lesson15

# nginx.conf for step3 (ConfigMap from file)
cat > /root/nginx.conf << 'EOF'
server {
    listen 80;
    location / { return 200 "frontend: OK\n"; add_header Content-Type text/plain; }
    location /healthz { return 200 "healthy\n"; add_header Content-Type text/plain; }
}
EOF

# Pod manifest for step3 (mounts nginx-config ConfigMap)
cat > /root/nginx-configured-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: nginx-configured
  namespace: lesson15
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    volumeMounts:
    - name: config-volume
      mountPath: /etc/nginx/conf.d
  volumes:
  - name: config-volume
    configMap:
      name: nginx-config
EOF

# Ingress manifest for step8
cat > /root/app-ingress.yaml << 'EOF'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: lesson15
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api
            port:
              number: 80
EOF

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
