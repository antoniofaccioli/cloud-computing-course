# Step 5 — Create the PersistentVolumeClaim

Inspect the PVC manifest:

`cat /root/telemetry-pvc.yaml`{{execute}}

Apply it:

`kubectl apply -f /root/telemetry-pvc.yaml`{{execute}}

Verify it is bound:

`kubectl get pvc`{{execute}}

The status must be `Bound` before proceeding. The local-path provisioner has automatically created a PersistentVolume to satisfy the claim.

Inspect the PV that was created:

`kubectl get pv`{{execute}}

Note that the PV is cluster-scoped — it has no namespace. The PVC that claimed it is in the `default` namespace.
