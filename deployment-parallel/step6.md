# Step 6 — Roll back

Inspect the revision history:

```
kubectl rollout history deployment/app-deployment
```{{exec}}

Roll back to the previous revision:

```
kubectl rollout undo deployment/app-deployment
```{{exec}}

Watch the rollback:

```
kubectl rollout status deployment/app-deployment
```{{exec}}

Verify the image has reverted:

```
kubectl describe pods -l app=myapp | grep Image:
```{{exec}}

Check the revision history one more time:

```
kubectl rollout history deployment/app-deployment
```{{exec}}

Notice that the revision numbers have shifted — the old revision 1 has become the latest entry.

---

### 🎯 Kahoot question 6

**After kubectl rollout undo, which mechanism restores the previous version?**

Answer question 6 on Kahoot now, then move to the next step.
