# Step 4 — Live update without Pod restart

This is the key advantage of volume-mounted ConfigMaps over env var injection.

Update the ConfigMap to change the response message:

```bash
kubectl patch configmap nginx-config -n lesson15 \
  --type merge \
  -p '{"data":{"default.conf":"server { listen 80; location / { return 200 \"frontend: UPDATED\n\"; add_header Content-Type text/plain; } }"}}'
```{{exec}}

Wait a few seconds, then read the file inside the running Pod — without restarting it:

```{{exec}}bash
sleep 10 && kubectl exec nginx-configured -n lesson15 -- cat /etc/nginx/conf.d/default.conf
```{{exec}}

The file content has changed inside the container, and the Pod was never restarted. This is possible because Kubernetes updates mounted ConfigMap files automatically via the kubelet sync loop.

Confirm the Pod is still the same (check the age):

```bash
kubectl get pod nginx-configured -n lesson15
```{{exec}}

**Important:** the file is updated on disk, but the application process must re-read it to apply the change. Nginx does not auto-reload config files — an application designed to watch its config file would pick up the change immediately.
