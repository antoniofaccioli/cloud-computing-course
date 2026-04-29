# Step 5 — Create a Secret

Secrets work like ConfigMaps but are designed for sensitive data. Kubernetes stores them encrypted at rest in etcd and distributes them only to nodes that need them.

Create a Secret with database credentials:

```bash
kubectl create secret generic db-secret \
  --from-literal=DB_HOST=postgres.internal \
  --from-literal=DB_PASSWORD=s3cr3tP@ss \
  -n lesson15
```{{exec}}

Inspect the Secret:

```{{exec}}bash
kubectl get secret db-secret -n lesson15 -o yaml
```{{exec}}

Notice that the values under `data` are **Base64-encoded**, not plain text. Base64 is not encryption — it is an encoding scheme that allows Secrets to store binary data alongside text. Decode one value to verify:

```bash
kubectl get secret db-secret -n lesson15 -o jsonpath='{.data.DB_PASSWORD}' | base64 -d
```{{exec}}

You get the original value back. The real security comes from the cluster-level protections: encryption at rest in etcd, selective distribution to nodes, and in-memory storage (never written to node disk).

Compare with the ConfigMap:

```{{exec}}bash
kubectl get configmap app-config -n lesson15 -o jsonpath='{.data.LOG_LEVEL}'
```{{exec}}

ConfigMap values are returned as plain text with no encoding.
