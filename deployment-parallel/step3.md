# Step 3 — Expose with NodePort

Apply the NodePort Service:

```
kubectl apply -f /root/app-nodeport.yaml
```{{exec}}

Inspect the Service:

```
kubectl get service app-svc
```{{exec}}

Note the `PORT(S)` column — it shows `80:30080/TCP`. This means:
- port `80` is the ClusterIP port (internal)
- port `30080` is the NodePort (external, open on every node)

Get the node's IP address:

```
kubectl get nodes -o wide
```{{exec}}

Use the `INTERNAL-IP` from the output above to reach the application from outside the cluster:

```
curl -s http://<INTERNAL-IP>:30080 | head -5
```{{exec}}

You should see the nginx welcome page HTML.

Check the Endpoints to confirm the Service is routing to the correct Pods:

```
kubectl get endpoints app-svc
```{{exec}}

---

### 🎯 Kahoot question 3

**A NodePort Service on port 30080. A client sends a request to NodeIP:30080. What happens?**

Answer question 3 on Kahoot now, then move to the next step.
