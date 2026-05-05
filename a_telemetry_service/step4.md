# Step 4 — Crash the Pod and observe data loss

In the **first terminal**, delete the Pod to simulate a crash:

`kubectl delete pod -l app=telemetry-api`{{execute}}

Watch the Deployment controller bring it back:

`kubectl rollout status deployment/telemetry-api`{{execute}}

The loop in the second terminal will show connection errors for a few seconds — that is the Pod restarting. Once the new Pod is ready, query the API:

`curl -s http://localhost:30080/readings`{{execute}}

The response is an empty array. Every reading is gone.

The Pod was replaced by the Deployment controller, but the new container started from a blank image. The SQLite file `/data/readings.db` was inside the container's writable layer — when the Pod was deleted, that layer was discarded with it.

Stop the loop in the second terminal with `Ctrl+C`, then clean up:

`kubectl delete -f /root/deploy-no-pvc.yaml`{{execute}}
