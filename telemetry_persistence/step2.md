# Step 2 — Deploy without storage and simulate readings

Deploy the service without a PVC and wait for it to be ready. Then open the second terminal and simulate a stream of sensor readings. Verify the readings are accumulating before moving on.

---

**Commands available for this step:**

- `kubectl apply`
- `kubectl rollout status`
- `kubectl get pods`
- `curl` with `POST /readings` and `GET /readings`
- `shuf` to generate random values
- `python3` to count readings
