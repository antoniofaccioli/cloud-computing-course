# Step 1 — How many nodes?

Run the following command and read the output carefully:

```
kubectl get nodes
```{{exec}}

Look at the columns:
- **NAME** — the hostname of the node
- **STATUS** — whether the node is ready to accept workloads
- **ROLES** — the role this node plays in the cluster
- **VERSION** — the Kubernetes version running on this node


---

