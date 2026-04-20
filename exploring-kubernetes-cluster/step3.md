# Step 3 — Inspecting the API Server

The API Server is the single entry point for all cluster interactions. Inspect its pod in detail:

```
kubectl describe pod kube-apiserver-controlplane -n kube-system
```{{exec}}

Scroll through the output and look for:

- **Image** — the container image and version of the API Server
- **Command** — the flags the API Server was started with. You will see flags like `--etcd-servers`, confirming that the API Server connects directly to etcd
- **Ports** — port `6443` is the HTTPS port that `kubectl` connects to
- **Mounts** — the API Server mounts the cluster certificates from the host filesystem

---

Now look at where the API Server configuration lives on disk. Static pod manifests are stored here:

```
ls /etc/kubernetes/manifests/
```{{exec}}

You will find one YAML file per Control Plane component. These are the manifests the kubelet reads directly to start and maintain the Control Plane pods — without the API Server being involved.
