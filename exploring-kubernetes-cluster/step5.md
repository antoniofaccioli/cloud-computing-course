# Step 5 — Worker Node components

Unlike Control Plane components, the **kubelet** and **kube-proxy** do not run as pods — they run as system daemons directly on the node.

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

Now check kube-proxy. Unlike the kubelet, kube-proxy runs as a DaemonSet pod — one instance per node:

```
kubectl get daemonset -n kube-system
```{{exec}}

```
kubectl describe daemonset kube-proxy -n kube-system
```{{exec}}

In the output note the **Image** and the **Node-Selector** — kube-proxy is scheduled on every node in the cluster automatically.
