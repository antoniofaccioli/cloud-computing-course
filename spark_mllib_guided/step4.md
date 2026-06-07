## Step 4 — Distributed joins and data skew

Run the joins and skew script:

```
docker run --rm -v /root/spark-lab/data:/data spark-mllib:latest /opt/spark/bin/spark-submit /data/joins_skew.py
```{{exec}}

Observe three outputs:

**Key distribution** — 90 out of 100 rows have `country='US'`. This is a skewed key: a shuffle join on this column would send 90% of the data to a single partition, creating a straggler task.

**Broadcast join result** — the `profiles` table (3 rows) is broadcast to every executor. No shuffle is needed. The aggregated totals per country and region are computed correctly.

**Salted join result** — the same join is repeated with a salt factor of N=5. Each country key is split into five variants (`US_0` through `US_4`). The aggregated totals are identical to the broadcast join — salting changes the partition distribution, not the result.

Verify the totals match between the two join approaches:

```
grep -A 10 "Broadcast join" /root/spark-lab/data/joins_skew.py
```{{exec}}
