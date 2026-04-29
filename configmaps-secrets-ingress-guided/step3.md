# Step 3 — Mount the ConfigMap as a file

When a ConfigMap holds an entire configuration file, it is better to mount it as a volume. Each key in the ConfigMap becomes a file in the mounted directory.

Create a ConfigMap from a pre-written file:

```bash
kubectl create configmap nginx-config --from-file=/root/nginx.conf -n lesson15
```{{exec}}

The file `/root/nginx.conf` is already available in your environment. Inspect the ConfigMap — notice that the entire file content became the value of a single key:

```bash
kubectl get configmap nginx-config -n lesson15 -o yaml
```{{exec}}

Now apply the Pod that mounts this ConfigMap as a volume:

```bash
kubectl apply -f /root/nginx-configured-pod.yaml
```{{exec}}

Wait for the Pod to be ready:

```bash
kubectl wait pod nginx-configured -n lesson15 --for=condition=Ready --timeout=60s
```{{exec}}

Verify that the ConfigMap key became a file inside the container:

```bash
kubectl exec nginx-configured -n lesson15 -- ls /etc/nginx/conf.d/
```{{exec}}

```bash
kubectl exec nginx-configured -n lesson15 -- cat /etc/nginx/conf.d/nginx.conf
```{{exec}}

The key `nginx.conf` became a file at that path. Each key in the ConfigMap becomes a separate file in the mounted directory.
