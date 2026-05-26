# Step 3 — Populating the sensor fleet

The file `/root/insert_many.js` inserts five more sensors covering three device types, three buildings, and varying battery levels and statuses.

Copy the file into the container:

```bash
docker cp /root/insert_many.js mongo:/tmp/insert_many.js
```{{exec}}

Execute the script:

```bash
docker exec mongo mongosh sensor_registry /tmp/insert_many.js
```{{exec}}

Confirm the total document count:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.countDocuments()'
```{{exec}}

Expected: `6`.
