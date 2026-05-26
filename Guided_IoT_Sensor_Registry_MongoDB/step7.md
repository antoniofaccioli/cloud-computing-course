# Step 7 — Deleting documents and final check

Sensor SNS-004 has been physically decommissioned. Remove it from the registry:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.deleteOne({ device_id: "SNS-004" })'
```{{exec}}

Confirm the deletion — the result should be `null`:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.findOne({ device_id: "SNS-004" })'
```{{exec}}

Verify the final document count:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.countDocuments()'
```{{exec}}

Expected: `5`.

Confirm no sensor remains in maintenance status:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.countDocuments({ status: "maintenance" })'
```{{exec}}

Expected: `0`.
