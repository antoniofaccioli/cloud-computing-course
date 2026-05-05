# Step 6 — Trace the storage chain

Inspect the storage objects and trace the full path from Pod to disk. Be able to answer: which PV is the PVC bound to? At which path is the volume mounted inside the container?

---

**Commands available for this step:**

- `kubectl get pv,pvc`
- `kubectl describe pvc`
- `kubectl describe pod`
