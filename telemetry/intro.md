# From data loss to persistence: a telemetry service

A sensor telemetry service is waiting to be built and deployed. It exposes two endpoints:

- `POST /readings` — record a sensor measurement
- `GET /readings` — retrieve all stored measurements

Data is stored in a SQLite database file at `/data/readings.db`.

In this exercise you will:

1. Build the container image from source
2. Deploy the service **without** persistent storage
3. Simulate a stream of sensor readings using a loop in a second terminal
4. Crash the Pod and observe that all readings are lost
5. Redeploy with a PersistentVolumeClaim and prove that readings survive

This is not a toy scenario — it represents exactly what happens in production when a telemetry backend loses its storage.
