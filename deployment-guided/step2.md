# Step 2 — Observe the controller hierarchy

When you created the Deployment, Kubernetes automatically created a ReplicaSet to manage the Pods.
Let's inspect the full hierarchy: Deployment → ReplicaSet → Pods.

List the ReplicaSet that the Deployment created:

```
kubectl get replicaset
```{{exec}}

Notice the name — it follows the pattern `web-deployment-<hash>`. The hash is generated from the Pod template and changes every time the template is updated (for example, when you change the image).

Get more detail on the ReplicaSet:

```
kubectl describe replicaset -l app=web
```{{exec}}

Look for the `Controlled By` field — it shows that the ReplicaSet is owned by the Deployment.
Now check the same on one of the Pods:

```
kubectl describe pod -l app=web | grep -A1 "Controlled By"
```{{exec}}

The Pod is controlled by the ReplicaSet, which is controlled by the Deployment.
This three-layer hierarchy is what enables self-healing and zero-downtime updates.

Finally, get a summary of all three layers together:

```
kubectl get deployment,replicaset,pod -l app=web
```{{exec}}
