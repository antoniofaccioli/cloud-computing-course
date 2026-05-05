# Step 2 — Deploy without persistent storage

Inspect the first deployment manifest — note there are no `volumes` or `volumeMounts`:

`cat /root/deploy-no-pvc.yaml`{{execute}}

Apply it:

`kubectl apply -f /root/deploy-no-pvc.yaml`{{execute}}

Wait for the Pod to be ready:

`kubectl rollout status deployment/telemetry-api`{{execute}}

Verify the API is responding:

`curl -s http://localhost:30080/readings`{{execute}}

You should see an empty array — no readings yet.
