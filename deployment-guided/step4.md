# Step 4 — Perform a rolling update

We want to update the application from `nginx:1.14` to `nginx:1.25`.
With the RollingUpdate strategy, Kubernetes will:
1. Create one new Pod with the new image (maxSurge: 1 → up to 4 Pods temporarily)
2. Wait for it to be Ready
3. Terminate one old Pod (maxUnavailable: 0 → the cluster never drops below 3 running Pods)
4. Repeat until all Pods use the new image

Update the image in the Deployment:

```
kubectl set image deployment/web-deployment nginx=nginx:1.25
```{{exec}}

Watch the rollout in real time:

```
kubectl rollout status deployment/web-deployment
```{{exec}}

While the rollout is in progress (or after it completes), observe the ReplicaSets:

```
kubectl get replicaset
```{{exec}}

You will see **two** ReplicaSets: the old one (scaling down to 0) and a new one (scaling up to 3).
Each ReplicaSet corresponds to a version of the Pod template — the old image and the new image.

Once the rollout is complete, verify all Pods are running the new image:

```
kubectl describe pods -l app=web | grep Image:
```{{exec}}

All three Pods should show `nginx:1.25`.
