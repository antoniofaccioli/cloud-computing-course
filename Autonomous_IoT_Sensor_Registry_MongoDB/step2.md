# Step 2 — Insert the first sensor

**Objective:** Insert the following document into the `sensors` collection of the `sensor_registry` database.

```
device_id : "SNS-001"
name      : "Temperature Sensor Alpha"
type      : "temperature"
location  : { building: "A", floor: 2, room: "Lab-201" }
specs     : { firmware: "v2.1.0", battery_pct: 87, sampling_rate_s: 30 }
tags      : ["outdoor", "critical"]
status    : "active"
```

**Expected output:** `acknowledged: true` with a generated `insertedId`.
After inserting, retrieve the document and verify that the nested structure is persisted correctly.

**Commands to use:** `db.sensors.insertOne()`, `db.sensors.findOne()`

> The database `sensor_registry` is created automatically on the first write — no setup command needed.
> For complex documents, consider writing a JavaScript file, copying it into the container with `docker cp`, and running it with `mongosh database_name script.js`.
> When running a script file, mongosh does **not** print results automatically — wrap your call in `printjson(...)` to see the output.
