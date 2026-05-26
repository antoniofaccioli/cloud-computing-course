# Step 3 — Populating the sensor fleet

The file `/root/insert_many.js` inserts five more sensors covering three device types, three buildings, and varying battery levels:

```javascript
printjson(db.sensors.insertMany([
  { device_id: "SNS-002", type: "humidity",    location: { building: "A" }, specs: { battery_pct: 45  }, status: "active"      },
  { device_id: "SNS-003", type: "temperature", location: { building: "B" }, specs: { battery_pct: 92  }, status: "active"      },
  { device_id: "SNS-004", type: "pressure",    location: { building: "B" }, specs: { battery_pct: 12  }, status: "maintenance" },
  { device_id: "SNS-005", type: "temperature", location: { building: "C" }, specs: { battery_pct: 78  }, status: "active"      },
  { device_id: "SNS-006", type: "humidity",    location: { building: "C" }, specs: { battery_pct: 61  }, status: "active"      }
  // full schema in /root/insert_many.js
]))
```

Copy the file into the container:

```bash
docker cp /root/insert_many.js mongo:/tmp/insert_many.js
```

Execute the script:

```bash
docker exec mongo mongosh sensor_registry /tmp/insert_many.js
```

Confirm the total document count:

```bash
docker exec mongo mongosh sensor_registry --eval 'db.sensors.countDocuments()'
```

Expected: `6`.
