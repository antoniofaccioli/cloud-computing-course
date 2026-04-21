# Step 7 — Static pods

Control Plane components are managed differently from regular pods — they are called **static pods** because they are defined by files on disk that the kubelet reads directly.

List the files in the static pod directory:

```
ls /etc/kubernetes/manifests/
```{{exec}}

You will see one YAML file per Control Plane component. The kubelet watches this directory and keeps those pods running regardless of cluster state.

Open one to confirm:

```
cat /etc/kubernetes/manifests/kube-scheduler.yaml | grep "image:"
```{{exec}}

This is the manifest that tells the kubelet exactly which container image to run for the scheduler.

