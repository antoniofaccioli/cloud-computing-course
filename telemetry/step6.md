# Step 6 — Deploy with persistent storage

Inspect the second deployment manifest and find the `volumes` and `volumeMounts` sections:

`cat /root/deploy-with-pvc.yaml`{{execute}}

The volume mounts `/data` inside the container — this is where the SQLite file will live, on the PVC instead of the container's ephemeral writable layer.

Apply it:

`kubectl apply -f /root/deploy-with-pvc.yaml`{{execute}}

Wait for the Pod:

`kubectl rollout status deployment/telemetry-api`{{execute}}

Verify the API is responding:

`curl -s http://localhost:30080/readings`{{execute}}
