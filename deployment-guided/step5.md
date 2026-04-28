# Step 5 — Inspect the rollout history

Every time you update a Deployment, Kubernetes records the change as a new revision.
This revision history is what makes rollback possible.

View the rollout history:

```
kubectl rollout history deployment/web-deployment
```{{exec}}

You will see two revisions:
- Revision 1: the initial Deployment with `nginx:1.14`
- Revision 2: the update to `nginx:1.25`

The `CHANGE-CAUSE` column is empty because we did not annotate the change.
In production, it is good practice to record the reason for each update:

```
kubectl annotate deployment/web-deployment kubernetes.io/change-cause="Updated nginx to 1.25"
```{{exec}}

Check the history again:

```
kubectl rollout history deployment/web-deployment
```{{exec}}

To inspect the details of a specific revision, use the `--revision` flag:

```
kubectl rollout history deployment/web-deployment --revision=1
```{{exec}}

This shows the Pod template for revision 1, including the `nginx:1.14` image.
