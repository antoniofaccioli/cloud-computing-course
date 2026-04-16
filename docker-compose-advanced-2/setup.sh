#!/bin/bash

# Install Docker Compose plugin (Docker is already installed and running)
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 \
  -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Create project directory
mkdir -p /root/app

# Create the Flask API application
cat > /root/app/app.py << 'EOF'
from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def index():
    return jsonify({
        "service": "api",
        "env": os.environ.get("APP_ENV", "unknown"),
        "db_user": os.environ.get("DB_USER", "not set"),
        "message": "Hello from the API"
    })

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    port = int(os.environ.get("API_PORT", 5000))
    app.run(host="0.0.0.0", port=port)
EOF

cat > /root/app/requirements.txt << 'EOF'
flask==3.0.3
EOF

echo "Ready"
