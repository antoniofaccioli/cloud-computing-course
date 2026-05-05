# Step 5 — Simulate readings, crash, and verify persistence

Restart the simulation loop in the second terminal. Let readings accumulate. Get the Pod name, delete it by name, wait for recovery, stop the loop, and verify all readings are still present.

---

**Commands available for this step:**

- `kubectl get pods`
- `kubectl delete pod <pod-name>`
- `kubectl rollout status`
- `curl` with `GET /readings`
- `python3` to count readings
- `shuf` to generate random values
