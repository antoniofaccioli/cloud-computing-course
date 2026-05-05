# Step 4 — Crash the Pod and observe data loss

In the **first terminal**, get the exact name of the running Pod:

`kubectl get pods`{{execute}}

Delete it by name to simulate a crash (replace `<pod-name>` with the actual name):

`kubectl delete pod <pod-name>`{{execute}}

Watch the Deployment controller bring a new Pod back:

`kubectl rollout status deployment/telemetry-api`{{execute}}

Once the new Pod is ready, query the API:

`curl -s http://localhost:30080/readings`{{execute}}

The response is an empty array. Every reading is gone.

The Pod was replaced by the Deployment controller, but the new container started from a blank image. The SQLite file `/data/readings.db` was inside the container's ephemeral writable layer — when the Pod was deleted, that layer was discarded with it.

Stop the loop in the second terminal with `Ctrl+C`, then clean up:

`kubectl delete -f /root/deploy-no-pvc.yaml`{{execute}}
