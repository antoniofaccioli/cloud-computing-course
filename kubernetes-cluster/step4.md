# Step 4 — etcd on disk

Inspect the etcd pod to find where it stores data:

```
kubectl describe pod -n kube-system -l component=etcd
```{{exec}}

In the **Command** section, look for the flag `--data-dir`. It points to a directory on the node filesystem where etcd persists all cluster state.

Now verify that directory exists on disk:

```
ls /var/lib/etcd/
```{{exec}}

Everything Kubernetes knows — every Pod, Deployment, ConfigMap, Secret — is stored here as key-value pairs.

