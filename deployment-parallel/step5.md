# Step 5 — Perform a rolling update

Update the container image from `nginx:1.21` to `nginx:1.25`:

```
kubectl set image deployment/app-deployment app=nginx:1.25
```{{exec}}

Watch the rollout:

```
kubectl rollout status deployment/app-deployment
```{{exec}}

While the rollout is in progress, observe the two ReplicaSets coexisting:

```
kubectl get replicaset
```{{exec}}

You will see the old ReplicaSet scaling down and the new one scaling up.

Once the rollout completes, verify the new image is running:

```
kubectl describe pods -l app=myapp | grep Image:
```{{exec}}

---

### 🎯 Kahoot question 5

**RollingUpdate: maxSurge 1, maxUnavailable 0, replicas 4. Max Pods at any moment?**

Answer question 5 on Kahoot now, then move to the next step.
