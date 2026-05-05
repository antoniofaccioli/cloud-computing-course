#!/bin/bash

until kubectl get nodes | grep -q " Ready"; do
  sleep 3
done

mkdir -p /root/telemetry-api

cat > /root/telemetry-api/app.py << 'EOF'
import sqlite3
import os
import json
from http.server import HTTPServer, BaseHTTPRequestHandler

DB_PATH = os.environ.get("DB_PATH", "/data/readings.db")

def init_db():
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS readings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sensor TEXT NOT NULL,
            value REAL NOT NULL,
            ts DATETIME DEFAULT (datetime('now'))
        )
    """)
    conn.commit()
    conn.close()

class Handler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass

    def do_GET(self):
        if self.path == "/healthz":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"ok")
            return
        if self.path == "/readings":
            conn = sqlite3.connect(DB_PATH)
            rows = conn.execute(
                "SELECT id, sensor, value, ts FROM readings ORDER BY id"
            ).fetchall()
            conn.close()
            data = [{"id": r[0], "sensor": r[1], "value": r[2], "ts": r[3]} for r in rows]
            body = json.dumps(data).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(body)
            return
        self.send_response(404)
        self.end_headers()

    def do_POST(self):
        if self.path == "/readings":
            length = int(self.headers.get("Content-Length", 0))
            body = json.loads(self.rfile.read(length))
            conn = sqlite3.connect(DB_PATH)
            cur = conn.execute(
                "INSERT INTO readings (sensor, value) VALUES (?, ?) RETURNING id, sensor, value, ts",
                (body["sensor"], body["value"])
            )
            row = cur.fetchone()
            conn.commit()
            conn.close()
            resp = json.dumps({"id": row[0], "sensor": row[1], "value": row[2], "ts": row[3]}).encode()
            self.send_response(201)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(resp)
            return
        self.send_response(404)
        self.end_headers()

if __name__ == "__main__":
    init_db()
    print("Telemetry API running on :5000", flush=True)
    HTTPServer(("0.0.0.0", 5000), Handler).serve_forever()
EOF

cat > /root/telemetry-api/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY app.py .
CMD ["python", "app.py"]
EOF

cat > /root/deploy-no-pvc.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: telemetry-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: telemetry-api
  template:
    metadata:
      labels:
        app: telemetry-api
    spec:
      containers:
        - name: api
          image: telemetry-api:local
          imagePullPolicy: Never
          env:
            - name: DB_PATH
              value: /data/readings.db
          ports:
            - containerPort: 5000
          readinessProbe:
            httpGet:
              path: /healthz
              port: 5000
            initialDelaySeconds: 2
            periodSeconds: 3
---
apiVersion: v1
kind: Service
metadata:
  name: telemetry-api
spec:
  type: NodePort
  selector:
    app: telemetry-api
  ports:
    - port: 80
      targetPort: 5000
      nodePort: 30080
EOF

cat > /root/telemetry-pvc.yaml << 'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: telemetry-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

cat > /root/deploy-with-pvc.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: telemetry-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: telemetry-api
  template:
    metadata:
      labels:
        app: telemetry-api
    spec:
      containers:
        - name: api
          image: telemetry-api:local
          imagePullPolicy: Never
          env:
            - name: DB_PATH
              value: /data/readings.db
          ports:
            - containerPort: 5000
          readinessProbe:
            httpGet:
              path: /healthz
              port: 5000
            initialDelaySeconds: 2
            periodSeconds: 3
          volumeMounts:
            - name: telemetry-storage
              mountPath: /data
      volumes:
        - name: telemetry-storage
          persistentVolumeClaim:
            claimName: telemetry-data
---
apiVersion: v1
kind: Service
metadata:
  name: telemetry-api
spec:
  type: NodePort
  selector:
    app: telemetry-api
  ports:
    - port: 80
      targetPort: 5000
      nodePort: 30080
EOF

echo "Setup complete."
