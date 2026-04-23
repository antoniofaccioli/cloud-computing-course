# Step 4 — What happens when you delete a bare Pod?

A bare Pod — one not managed by any controller — has no self-healing. When it is deleted, it is gone permanently.

Delete the Pod:

```
kubectl delete pod shared-volume-pod
```{{exec}}

Check the Pod list:

```
kubectl get pods
```{{exec}}

The output shows `No resources found in default namespace`. The Pod is gone and no replacement was created. There is no controller watching for its absence.

**Compare this with what you know from Docker Compose:** in Compose, if a container crashes and `restart: always` is set, the Docker daemon restarts it on the same host. In Kubernetes, self-healing is the responsibility of a **controller** — specifically a `Deployment` backed by a `ReplicaSet`. These controllers continuously compare the actual state (how many Pods are running) with the desired state (how many Pods should be running) and act to reconcile any difference.

**The question for the next lesson:** how does a Deployment track which Pods it owns? The answer is labels and label selectors — and you already added a label to your first manifest in Step 1.
