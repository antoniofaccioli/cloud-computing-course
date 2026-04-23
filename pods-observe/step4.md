# Step 4 — The Pod IP

Get the extended view of the Pod including its IP address and the node it runs on:

```
kubectl get pod fixed-pod -o wide
```{{exec}}

Note the value in the `IP` column. This is the Pod's IP address on the cluster network.

Now retrieve it directly with jsonpath:

```
kubectl get pod fixed-pod -o jsonpath='{.status.podIP}' && echo ""
```{{exec}}

This IP is reachable from any other Pod in the cluster, but not from outside the cluster. To understand which network range it belongs to, inspect the node:

```
kubectl get node -o jsonpath='{.items[0].spec.podCIDR}' && echo ""
```{{exec}}

Compare the Pod IP with the node's `podCIDR`. You will see that the Pod IP falls inside that range — it was assigned from the block allocated to this node.

> **Your instructor will now launch Kahoot question 4.**
> Look at the CIDR range and the Pod IP before answering.
