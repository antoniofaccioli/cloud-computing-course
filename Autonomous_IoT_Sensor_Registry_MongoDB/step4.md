# Step 4 — Query the collection

**Objective:** Run the following four queries and verify each result.

1. Find all sensors with `status: "active"`. Expected: **5 documents**.

2. Find sensors with `battery_pct` greater than 70. Return only `device_id` and `battery_pct` — exclude `_id`. Expected: **4 documents**.

3. Find sensors of type `"temperature"` or `"humidity"` in a single query. Expected: **5 documents**.

4. Find sensors whose `tags` array contains the string `"critical"`. Expected: **2 documents** (SNS-001 and SNS-004).

**Commands to use:** `db.sensors.find()`, `.toArray()`

**Operators:** `$gt`, `$in`

**Tips:**
- Use dot-notation `"parent.field"` to filter on fields inside nested objects (e.g. `"specs.battery_pct"`)
- Pass a second argument to `find()` to define a projection: `{ field: 1, _id: 0 }`
- MongoDB searches inside arrays automatically — no special operator needed to match array elements by value
