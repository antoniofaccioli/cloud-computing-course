# Step 1 — Add a third service with its own ConfigMap

**Objective:** deploy a `dashboard` service in namespace `lesson15` with a dedicated ConfigMap that is mounted as a file inside the container.

**What you need to create:**

- A ConfigMap named `dashboard-config` with at least one key that will become a configuration file (e.g. a key `config.json` with a JSON value)
- A Deployment named `dashboard` using image `nginx:alpine`, with the ConfigMap mounted as a volume at `/etc/dashboard/`
- A ClusterIP Service named `dashboard` on port 80

**Verify:**

- The Pod is Running
- The file exists inside the container at `/etc/dashboard/config.json`
- The file content matches what you put in the ConfigMap

---

### Command hints

Create a ConfigMap from a literal value:
```
kubectl create configmap
```

Apply a YAML manifest:
```
kubectl apply -f
```

Check that the Pod is running:
```
kubectl get pods -n lesson15
```

Read a file inside a running container:
```
kubectl exec <pod> -n lesson15 -- cat <path>
```

In the Deployment spec, the relevant fields for mounting a ConfigMap as a volume are: `volumeMounts` (on the container) and `volumes` (at the Pod level, referencing the ConfigMap by name).
