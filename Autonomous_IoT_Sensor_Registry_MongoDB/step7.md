# Step 7 — Delete and verify

**Objective:** Perform the following operations in order.

1. Delete sensor `SNS-004` (the decommissioned pressure sensor) using a single-document delete.
2. Confirm the deletion: a lookup for `SNS-004` must return `null`.
3. Verify the final state:
   - Total `countDocuments()`: **5**
   - `countDocuments({ status: "maintenance" })`: **0**

**Commands to use:** `db.sensors.deleteOne()`, `db.sensors.findOne()`, `db.sensors.countDocuments()`
