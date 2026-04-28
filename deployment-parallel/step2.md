# Step 2 — Observe the ReplicaSet

List the ReplicaSet created by the Deployment:

```
kubectl get replicaset
```{{exec}}

Check which Deployment owns it:

```
kubectl describe replicaset -l app=myapp | grep -E "Name:|Controlled By:|Replicas:"
```{{exec}}

Verify the Pods are owned by the ReplicaSet:

```
kubectl describe pod -l app=myapp | grep -E "Name:|Controlled By:"
```{{exec}}

---

### 🎯 Kahoot question 2

**A ReplicaSet detects that one of its Pods has been deleted. What does it do?**

Answer question 2 on Kahoot now, then move to the next step.
