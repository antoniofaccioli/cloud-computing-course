#!/bin/bash

echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Available deployment/coredns -n kube-system --timeout=120s 2>/dev/null || true

cat > /root/app-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
  labels:
    app: myapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: nginx:1.21
        ports:
        - containerPort: 80
EOF

cat > /root/app-nodeport.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: app-svc
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
EOF

echo "Setup complete. Files ready in /root/"
