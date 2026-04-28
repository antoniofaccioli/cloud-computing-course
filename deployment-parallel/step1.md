# Step 1 — Apply the Deployment

Inspect the Deployment manifest:

```
cat /root/app-deployment.yaml
```{{exec}}

Apply it:

```
kubectl apply -f /root/app-deployment.yaml
```{{exec}}

Verify the Deployment and Pods are running:

```
kubectl get deployment app-deployment
```{{exec}}

```
kubectl get pods -l app=myapp
```{{exec}}

Wait until both Pods show `Running` before continuing.

---

### 🎯 Kahoot question 1

**A Deployment with `replicas: 2` is applied. How many ReplicaSets does Kubernetes create?**

Answer question 1 on Kahoot now, then move to the next step.
