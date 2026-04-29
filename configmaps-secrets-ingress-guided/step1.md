# Step 1 — Create a ConfigMap

A **ConfigMap** stores non-sensitive configuration as key-value pairs. The application does not need to know the ConfigMap exists — the cluster injects the values at runtime.

Create a ConfigMap named `app-config` with three entries:

```bash
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=LOG_LEVEL=info \
  --from-literal=MAX_CONNECTIONS=100 \
  -n lesson15
```{{exec}}

Inspect the result:

```{{exec}}bash
kubectl get configmap app-config -n lesson15 -o yaml
```{{exec}}

Notice that all values appear **in plain text** in the `data` field. ConfigMaps are not for sensitive data — that is what Secrets are for.

Also note the 1 MB size limit: ConfigMaps (and Secrets) are stored in etcd, which is optimised for small objects. Never store large files here.
