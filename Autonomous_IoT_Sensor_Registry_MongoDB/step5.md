# Step 5 — Update documents

**Objective:** Perform the following two update operations.

**Operation 1 — single document:**
Sensor SNS-001 has received a firmware upgrade. Update its `specs.firmware` field to `"v2.2.0"`.
Verify by retrieving `device_id` and `specs.firmware` for SNS-001.

**Operation 2 — multiple documents:**
All sensors in building A have passed a compliance audit. Append the tag `"audited"` to the `tags` array of every building A sensor.
Verify by retrieving `device_id` and `tags` for all building A sensors — both must now include `"audited"`.

**Commands to use:** `db.sensors.updateOne()`, `db.sensors.updateMany()`, `db.sensors.findOne()`, `db.sensors.find()`

**Update operators:** `$set` (replace or create a field), `$push` (append an element to an array)

> Use dot-notation for nested field paths in both the filter and the update document.
