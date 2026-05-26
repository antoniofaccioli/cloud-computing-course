# Step 6 — Aggregation pipeline

**Objective:** Write an aggregation pipeline that:

1. Keeps only sensors with `status: "active"`
2. Groups by sensor `type`, computing:
   - `total`: count of sensors per type
   - `avg_battery`: average of `specs.battery_pct` per type
3. Sorts the result by `total` descending

**Expected output:** two groups — `temperature` (3 sensors) and `humidity` (2 sensors).
The pressure sensor is in maintenance and must be excluded by the first stage.

**Commands to use:** `db.sensors.aggregate([ ... ])`

**Pipeline stages:** `$match`, `$group`, `$sort`

**Accumulators for `$group`:** `$sum`, `$avg`

> Write the pipeline as a JavaScript file and run it with `mongosh`. Use `printjson(result)` to display the output.
> Field references inside aggregation expressions use the `"$fieldName"` syntax (e.g. `"$type"`, `"$specs.battery_pct"`).
