# Step 7 — Simulate telemetry and crash the Pod again

In the **second terminal**, restart the telemetry simulation loop:

`while true; do VALUE=$(shuf -i 180-420 -n 1); SENSOR=$(shuf -e temp-01 temp-02 humidity-01 -n 1); curl -s -X POST http://localhost:30080/readings -H 'Content-Type: application/json' -d "{\"sensor\": \"$SENSOR\", \"value\": $VALUE}" > /dev/null; echo "Sent: $SENSOR = $VALUE"; sleep 2; done`{{execute T2}}

Let it run for 20–30 seconds. In the **first terminal**, check how many readings are stored:

`curl -s http://localhost:30080/readings | python3 -c "import sys,json; data=json.load(sys.stdin); print(f'{len(data)} readings stored')"`{{execute}}

Get the exact name of the running Pod:

`kubectl get pods`{{execute}}

Delete it by name (replace `<pod-name>` with the actual name):

`kubectl delete pod <pod-name>`{{execute}}

Watch recovery:

`kubectl rollout status deployment/telemetry-api`{{execute}}

Stop the loop in the second terminal with `Ctrl+C`. Query the API:

`curl -s http://localhost:30080/readings | python3 -c "import sys,json; data=json.load(sys.stdin); print(f'{len(data)} readings stored')"`{{execute}}

All readings are present. The new Pod reattached to the same PVC — and therefore to the same SQLite file on disk. The compute layer was replaced. The storage layer was not.
