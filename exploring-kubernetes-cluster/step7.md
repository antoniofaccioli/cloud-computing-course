# Step 7 — What happens when a Pod is deleted

A bare Pod — one created directly with `kubectl run`, not managed by a Deployment — is **not** rescheduled if deleted. This is one of the key limits of bare Pods discussed in the lesson.

Delete the Pod:

```
kubectl delete pod webserver
```{{exec}}

While it is terminating, immediately check the status in another command:

```
kubectl get pod webserver
```{{exec}}

You may briefly see `Terminating`. Once deletion completes, the pod is simply gone:

```
kubectl get pods
```{{exec}}

The list is empty. No controller noticed the gap — there is no desired state asking for a `webserver` pod to exist. The Pod is gone permanently.

---

This is exactly why bare Pods are rarely used in production. In the next lesson you will create a **Deployment**, which wraps a Pod in a controller that maintains desired state. Delete the Pod managed by a Deployment and it comes back automatically — because the Controller Manager detects the discrepancy and acts.

---

**Summary of what you have seen today:**

- Control Plane components run as static pods in `kube-system`
- The kubelet runs as a system daemon and is the engine behind everything
- kube-proxy runs as a DaemonSet on every node
- Pod creation follows a precise sequence: API Server → etcd → Scheduler → kubelet → container runtime
- Bare Pods have no self-healing — a controller is required for resilience
