# Step 5 — The kubelet

Unlike the Control Plane pods, the kubelet does not run inside Kubernetes — it runs directly on the node as a system process.

Check its status:

```
systemctl status kubelet
```{{exec}}

Look at the first line of the output. It tells you which tool is managing the kubelet process and whether it is currently active.

Press `q` to exit if the output is paginated.

