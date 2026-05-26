# Step 3 — Populate the sensor fleet

**Objective:** Insert the following five sensors in a single operation.

| device_id | type        | building | floor | room           | battery | status      | tags                        | firmware | sampling_rate_s |
|-----------|-------------|----------|-------|----------------|---------|-------------|-----------------------------|----------|----------------|
| SNS-002   | humidity    | A        | 2     | Lab-202        | 45%     | active      | ["indoor"]                  | v1.8.0   | 60             |
| SNS-003   | temperature | B        | 1     | Server-101     | 92%     | active      | ["outdoor","weatherproof"]  | v2.1.0   | 30             |
| SNS-004   | pressure    | B        | 3     | Roof-301       | 12%     | maintenance | ["critical"]                | v1.5.0   | 120            |
| SNS-005   | temperature | C        | 1     | Entrance-101   | 78%     | active      | ["outdoor","weatherproof"]  | v2.0.0   | 30             |
| SNS-006   | humidity    | C        | 2     | Storage-201    | 61%     | active      | ["indoor"]                  | v1.8.0   | 60             |

**Expected output:** `insertedCount: 5`. Then `countDocuments()` must return `6`.

**Commands to use:** `db.sensors.insertMany()`, `db.sensors.countDocuments()`

> Use the JavaScript file approach (`docker cp` + `mongosh db script.js`) for large multi-document inserts.
> Remember: mongosh does **not** print results automatically in script mode — use `printjson(...)` to display the output.
