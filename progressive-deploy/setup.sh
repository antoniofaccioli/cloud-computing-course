#!/bin/bash

# Install Docker Compose plugin (Docker is already installed and running)
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 \
  -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Create frontend app
mkdir -p /root/frontend

cat > /root/frontend/app.py << 'EOF'
from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def index():
    visits_file = "/app/data/visits.txt"
    count = 0
    if os.path.exists(visits_file):
        with open(visits_file) as f:
            count = int(f.read().strip() or 0)
    count += 1
    os.makedirs("/app/data", exist_ok=True)
    with open(visits_file, "w") as f:
        f.write(str(count))
    return f"<h1>Frontend</h1><p>Visit count: {count}</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

cat > /root/frontend/requirements.txt << 'EOF'
flask==3.0.3
EOF

# Dockerfile NON ottimizzato (COPY . . prima di pip install)
cat > /root/frontend/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
EOF

# Create backend app
mkdir -p /root/backend

cat > /root/backend/app.py << 'EOF'
from flask import Flask, jsonify
import os, json

app = Flask(__name__)

@app.route("/api")
def api():
    data_file = "/app/data/messages.json"
    messages = []
    if os.path.exists(data_file):
        with open(data_file) as f:
            messages = json.load(f)
    new_msg = f"Request #{len(messages) + 1}"
    messages.append(new_msg)
    os.makedirs("/app/data", exist_ok=True)
    with open(data_file, "w") as f:
        json.dump(messages, f)
    return jsonify({"service": "backend", "messages": messages})

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

cat > /root/backend/requirements.txt << 'EOF'
flask==3.0.3
EOF

# Dockerfile NON ottimizzato (stesso pattern del frontend)
cat > /root/backend/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
EOF

echo "Ready"
