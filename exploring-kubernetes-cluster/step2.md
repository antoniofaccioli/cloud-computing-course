# Step 2 — Control Plane components

Control Plane components run as **static Pods** in the `kube-system` namespace. List all pods in that namespace:

```
kubectl get pods -n kube-system
```{{exec}}

You will see pods with names like:
- `etcd-controlplane`
- `kube-apiserver-controlplane`
- `kube-controller-manager-controlplane`
- `kube-scheduler-controlplane`

These are the four Control Plane components from the lesson — running as ordinary pods managed directly by the kubelet, not by a Deployment or ReplicaSet.

You will also see `kube-proxy` and `coredns` pods. CoreDNS provides cluster-wide DNS resolution — the mechanism behind Kubernetes service discovery.

---

Get a wider view showing which node each pod runs on:

```
kubectl get pods -n kube-system -o wide
```{{exec}}

All pods should be on the single `controlplane` node and in `Running` status.
