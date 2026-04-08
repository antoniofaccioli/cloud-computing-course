#!/bin/bash
mkdir -p /root/app
cp /root/counter.py /root/app/counter.py
cp /root/requirements.txt /root/app/requirements.txt

cat > /root/app/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "counter.py"]
EOF
