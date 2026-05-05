# Step 8 — Trace the full storage chain

List all storage objects:

`kubectl get pv,pvc`{{execute}}

Describe the PVC to see which PV it is bound to and where the data lives:

`kubectl describe pvc telemetry-data`{{execute}}

Trace the chain from the running Pod down to the volume:

`kubectl describe pod -l app=telemetry-api | grep -A 10 Volumes`{{execute}}

You can follow the full path: Pod references the PVC by name → PVC is bound to the PV → PV maps to a directory on the node's disk where the SQLite file lives.

The compute layer is ephemeral. The storage layer is not.
