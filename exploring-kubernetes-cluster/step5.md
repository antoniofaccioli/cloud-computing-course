# Step 5 — Worker Node components

Unlike Control Plane components, the **kubelet** does not run as a pod — it runs as a system daemon directly on the node.

Check that the kubelet is running:

```
systemctl status kubelet
```{{exec}}

The output should show `active (running)`. The kubelet is managed by `systemd` and starts automatically when the node boots.

---

Check the kubelet configuration file:

```
cat /var/lib/kubelet/config.yaml | head -30
```{{exec}}

You can see settings like `staticPodPath` — this is where the kubelet looks for static pod manifests (the `/etc/kubernetes/manifests/` directory you saw in Step 3).

---

Now look at the network-related components running in `kube-system`. Node-level networking is handled by DaemonSet pods — one instance per node. List all DaemonSets:

```
kubectl get daemonset -n kube-system
```{{exec}}

Then list all pods in `kube-system` to see what is actually running:

```
kubectl get pods -n kube-system -o wide
```{{exec}}

Depending on the cluster configuration, you may see pods for `cilium`, `kube-proxy`, or another CNI implementation. Regardless of the name, the role is the same as described in the lesson: a network agent on every node that maintains the routing rules translating Service virtual IPs to the actual IP addresses of healthy Pods.
