# Step 2 — The Control Plane namespace

Run this command and observe the output:

```
kubectl get pods -n kube-system
```{{exec}}

You will see several pods. Identify the ones whose names start with:
- `kube-apiserver-`
- `kube-scheduler-`
- `kube-controller-manager-`
- `etcd-`

These are the four Control Plane components running as static pods.

Also note the namespace shown in the command flag — you specified it explicitly with `-n`.

