# Step 4 — Scale the Deployment

Scale the Deployment from 2 to 4 replicas:

```
kubectl scale deployment app-deployment --replicas=4
```{{exec}}

Watch the new Pods appear:

```
kubectl get pods -l app=myapp -w
```{{exec}}

Press `Ctrl+C` once all four Pods are `Running`.

Now check the Endpoints of the Service:

```
kubectl get endpoints app-svc
```{{exec}}

The Service automatically detected the new Pods and added them to the Endpoints list.
No changes to the Service manifest were needed — the label selector does the work.

Verify that the Service still works correctly:

```
curl -s http://<INTERNAL-IP>:30080 -o /dev/null -w "%{http_code}\n"
```{{exec}}

---

### 🎯 Kahoot question 4

**A ClusterIP Service has `selector: app: myapp`. The Deployment is scaled from 2 to 4 replicas. What happens to the Service Endpoints?**

Answer question 4 on Kahoot now, then move to the next step.
