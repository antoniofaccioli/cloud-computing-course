# Step 4 — Inspecting etcd

etcd is the key-value store that holds the entire cluster state. Inspect its pod:

```
kubectl describe pod etcd-controlplane -n kube-system
```{{exec}}

In the **Command** section look for:
- `--data-dir` — the directory on disk where etcd persists all cluster data
- `--listen-client-urls` — the address the API Server connects to (typically `https://127.0.0.1:2379`)
- `--initial-cluster` — in a multi-node setup this lists all etcd members for Raft consensus

---

Verify that etcd data is stored on the host filesystem:

```
ls /var/lib/etcd/
```{{exec}}

This directory contains the actual database files. Everything Kubernetes knows about your cluster — every Pod, Deployment, Secret, ConfigMap — is in here.

---

Finally, check the etcd manifest to see the version in use:

```
cat /etc/kubernetes/manifests/etcd.yaml | grep image:
```{{exec}}
