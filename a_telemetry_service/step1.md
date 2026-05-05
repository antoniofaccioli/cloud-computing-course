# Step 1 — Inspect the project and build the image

The telemetry API source code and Dockerfile are ready in `/root/telemetry-api/`. Take a moment to read them:

`cat /root/telemetry-api/app.py`{{execute}}

`cat /root/telemetry-api/Dockerfile`{{execute}}

Now build the container image with Docker:

`docker build -t telemetry-api:local /root/telemetry-api/`{{execute}}

The image is built locally by Docker. Kubernetes uses containerd as its runtime — they do not share the same image store. Import the image into containerd so that Kubernetes can use it:

`docker save telemetry-api:local | ctr -n k8s.io images import -`{{execute}}

Verify the image is visible to Kubernetes:

`crictl images | grep telemetry-api`{{execute}}
