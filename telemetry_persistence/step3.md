# Step 3 — Crash the Pod and observe data loss

Get the exact name of the running Pod, delete it by name, wait for recovery, stop the simulation loop, and verify the data is gone. Clean up the deployment before moving on.

---

**Commands available for this step:**

- `kubectl get pods`
- `kubectl delete pod <pod-name>`
- `kubectl rollout status`
- `curl` with `GET /readings`
- `kubectl delete`
