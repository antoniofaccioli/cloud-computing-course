# Step 5 — Create the PersistentVolumeClaim

Inspect the PVC manifest:

`cat /root/telemetry-pvc.yaml`{{execute}}

Apply it:

`kubectl apply -f /root/telemetry-pvc.yaml`{{execute}}

Check the status:

`kubectl get pvc`{{execute}}

You will see status `Pending` — this is expected and correct. The StorageClass uses `WaitForFirstConsumer` mode: the PersistentVolume is not created until a Pod actually mounts the volume. The PVC will become `Bound` automatically when the Deployment starts in the next step.
