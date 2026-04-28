#!/bin/bash

# Lesson 14 — Exercise A setup
# Creates all working files inline so no external assets are needed.

# Wait for the cluster to be fully ready
echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Available deployment/coredns -n kube-system --timeout=120s 2>/dev/null || true

# ── Deployment manifest ──────────────────────────────────────────────────────
cat > /root/web-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.14
        ports:
        - containerPort: 80
EOF

# ── Service manifest ──────────────────────────────────────────────────────────
cat > /root/web-service.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: web-svc
spec:
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
EOF

echo "Setup complete. Files ready in /root/"
