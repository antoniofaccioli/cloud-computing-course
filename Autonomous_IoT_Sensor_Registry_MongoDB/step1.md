# Step 1 — Start MongoDB and verify connectivity

**Objective:** Start a MongoDB 7 container named `mongo`, exposing port 27017, and confirm the server is responding.

**Expected output:** `{ ok: 1 }` from a ping command sent through `mongosh`.

**Commands to use:** `docker run`, `docker exec`, `mongosh --eval`, `db.adminCommand()`

> `docker run -d` and any `sleep` must be run as separate commands — never on the same line.
