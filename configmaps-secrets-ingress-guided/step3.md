# Step 3 — Mount the ConfigMap as a file

When a ConfigMap holds an entire configuration file, it is better to mount it as a volume. Create a ConfigMap from a multi-line value representing a configuration file:

```bash
kubectl create configmap nginx-config \
  --from-literal=default.conf='server {
    listen 80;
    location / { return 200 "frontend: OK\n"; add_header Content-Type text/plain; }
    location /healthz { return 200 "healthy\n"; add_header Content-Type text/plain; }
  }' \
  -n lesson15
```{{exec}}

Now create a Pod that mounts this ConfigMap as a file:

```{{exec}}bash
cat << 'EOF' | kubectl apply -f -
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
```{{exec}}

Wait for the Pod to be ready:

```bash
kubectl wait pod nginx-configured -n lesson15 --for=condition=Ready --timeout=60s
```{{exec}}

Verify that the ConfigMap key became a file inside the container:

```{{exec}}bash
kubectl exec nginx-configured -n lesson15 -- ls /etc/nginx/conf.d/
```{{exec}}

```bash
kubectl exec nginx-configured -n lesson15 -- cat /etc/nginx/conf.d/default.conf
```{{exec}}

The key `default.conf` became a file at that path. Each key in the ConfigMap becomes a separate file in the mounted directory.
