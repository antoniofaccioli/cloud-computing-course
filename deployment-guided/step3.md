# Step 3 — Verify self-healing

The ReplicaSet continuously monitors the cluster. If the number of running Pods drops below the
desired count, it immediately creates replacements. Let's test this.

First, note the name of one of the running Pods:

```
kubectl get pods -l app=web
```{{exec}}

Delete one Pod (replace `<pod-name>` with one of the actual Pod names from the list above):

```
kubectl delete pod <pod-name>
```{{exec}}

Immediately after deleting, watch what happens:

```
kubectl get pods -l app=web -w
```{{exec}}

You will see the deleted Pod enter `Terminating` status, and within seconds a new Pod appears
in `ContainerCreating` and then `Running`. The ReplicaSet detected the count dropped to 2
and created a replacement to restore it to 3.

Press `Ctrl+C` to stop watching.

> **Why does this matter?**
> On a real cluster, nodes fail, containers crash, and Out-Of-Memory events kill Pods without warning.
> The ReplicaSet guarantees the desired number of replicas is always maintained — without any
> human intervention.
