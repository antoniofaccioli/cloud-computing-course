# Step 1 — Create a Deployment

A Deployment is the standard way to run a stateless application in Kubernetes.
When you apply a Deployment manifest, Kubernetes creates a ReplicaSet, which in turn creates the Pods.

The manifest has already been prepared in `/root/web-deployment.yaml`. Inspect it first:

```
cat /root/web-deployment.yaml
```

Notice the key fields:
- `replicas: 3` — the desired number of Pod copies
- `selector.matchLabels` — how the Deployment identifies its Pods
- `strategy.rollingUpdate` — `maxSurge: 1` allows one extra Pod during updates; `maxUnavailable: 0` ensures no Pod goes down before a new one is ready
- `template` — the Pod blueprint used to create each replica

Now apply the manifest:

```
kubectl apply -f /root/web-deployment.yaml
```

Verify the Deployment was created and that Pods are starting:

```
kubectl get deployment web-deployment
```

```
kubectl get pods -l app=web
```

Wait until all three Pods show `Running` in the STATUS column before moving to the next step.
