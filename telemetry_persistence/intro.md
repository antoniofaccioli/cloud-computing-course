# Telemetry persistence — autonomous exercise

The same telemetry API project from Exercise A is in `/root/telemetry-api/`. All manifests are in `/root/`.

Reproduce the full scenario independently:

1. Build the image and import it into containerd
2. Deploy without persistent storage, simulate sensor readings, crash the Pod, observe data loss
3. Create the PVC, redeploy with persistent storage
4. Repeat the crash and verify the readings survive
5. Trace the full storage chain

A command reference is at the bottom of each step — use it only if you are stuck.

**Expected outcome:** you can explain why readings were lost in the first scenario and why they survived in the second, and trace the Pod → PVC → PV chain.
