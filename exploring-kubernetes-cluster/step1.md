# Step 1 — The cluster nodes

The first thing to do when working with a Kubernetes cluster is verify that the nodes are registered and ready.

Run the following command:

```
kubectl get nodes
```{{exec}}

You will see one node listed. The `STATUS` column should show `Ready`.

The `ROLES` column tells you which roles this node plays. In this single-node environment you will see `control-plane` — it runs both the Control Plane components and application workloads.

---

Now get more detail about the node:

```
kubectl get nodes -o wide
```{{exec}}

The additional columns show:
- **INTERNAL-IP** — the IP address of the node
- **CONTAINER-RUNTIME** — the container runtime in use (typically `containerd`)
- **OS-IMAGE** and **KERNEL-VERSION** — the underlying operating system

Notice the container runtime. This is the engine that the kubelet uses (via CRI) to pull images and run containers on this node.
