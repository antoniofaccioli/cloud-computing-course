# Exercise complete

You have experienced firsthand why persistent storage matters in Kubernetes.

Without a PVC, the SQLite file lived inside the container's writable layer — ephemeral by design, discarded on every Pod restart.

With a PVC, the file lives on a PersistentVolume that Kubernetes manages independently of any Pod. The volume survives crashes, rescheduling, and Deployment updates.

The same principle applies to any stateful workload: databases, message brokers, time-series stores. In the IoT lessons ahead, this same telemetry service will receive data from MQTT sensors instead of a curl loop — but the storage layer will work exactly the same way.
