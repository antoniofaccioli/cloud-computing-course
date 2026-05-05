# Step 3 — Simulate sensor telemetry

In a real deployment, sensor readings arrive continuously from physical devices. Here you will simulate this with a loop running in the **second terminal**.

In Killercoda you have two terminals available — look for the tab at the top of the terminal panel and open the second one.

Once the second terminal is open, start the telemetry simulation loop:

`while true; do VALUE=$(shuf -i 180-420 -n 1); SENSOR=$(shuf -e temp-01 temp-02 humidity-01 -n 1); curl -s -X POST http://localhost:30080/readings -H 'Content-Type: application/json' -d "{\"sensor\": \"$SENSOR\", \"value\": $VALUE}" > /dev/null; echo "Sent: $SENSOR = $VALUE"; sleep 2; done`{{execute T2}}

Leave this loop running. Switch back to the **first terminal** and watch the readings accumulate:

`curl -s http://localhost:30080/readings`{{execute}}

Run it a few times and watch the count grow. You now have a continuous stream of sensor data flowing into the database.

To count how many readings are stored:

`curl -s http://localhost:30080/readings | python3 -c "import sys,json; data=json.load(sys.stdin); print(f'{len(data)} readings stored')"`{{execute}}
