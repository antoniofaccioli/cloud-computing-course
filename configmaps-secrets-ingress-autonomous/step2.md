# Step 2 — Verify live ConfigMap update

**Objective:** prove that a volume-mounted ConfigMap updates inside the running Pod without a restart.

**What you need to do:**

- Update a value in `dashboard-config`
- Wait a few seconds for the kubelet sync loop to propagate the change
- Read the file inside the `dashboard` Pod and confirm the new value is present
- Confirm the Pod was **not** restarted

**Expected result:** the file content inside the container reflects the updated ConfigMap; the Pod age is unchanged and `RESTARTS` is still 0.

---

### Command hints

Edit a ConfigMap interactively:
```
kubectl edit configmap dashboard-config -n lesson15
```

Or patch a specific key:
```
kubectl patch configmap
```

Read the file inside the container again:
```
kubectl exec <pod> -n lesson15 -- cat /etc/dashboard/config.json
```

Check Pod restart count and age:
```
kubectl get pods -n lesson15
```

Note: the kubelet sync period is typically up to 60 seconds. If you do not see the change immediately, wait 15–30 seconds and check again.
