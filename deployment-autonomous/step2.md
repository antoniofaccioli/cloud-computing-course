# Verification checklist

Use these commands to verify each objective was completed correctly.

---

**Objective 1 — Deployment**

```
kubectl get deployment store-deployment
kubectl get pods -l app=store
```{{exec}}

Expected: `READY 3/3` on the Deployment; all 3 Pods in `Running` state.

---

**Objective 2 — NodePort Service**

```
kubectl get service store-svc
kubectl get endpoints store-svc
```{{exec}}

Expected: Service type `NodePort`, port mapping `80:30090/TCP`; Endpoints lists 3 Pod IPs.

---

**Objective 3 — Scale up**

```
kubectl get deployment store-deployment
kubectl get endpoints store-svc
```{{exec}}

Expected: `READY 5/5`; Endpoints lists 5 Pod IPs.

---

**Objective 4 — Rolling update**

```
kubectl describe pods -l app=store | grep Image:
kubectl rollout history deployment/store-deployment
```{{exec}}

Expected: all Pods show `httpd:2.4.58`; revision history shows at least 2 entries.

---

**Objective 5 — Rollback**

```
kubectl describe pods -l app=store | grep Image:
kubectl rollout history deployment/store-deployment
```{{exec}}

Expected: all Pods show `httpd:2.4`; revision history shows a new entry.

---

**Objective 6 — DNS resolution**

```
kubectl run debug --image=curlimages/curl --rm -it --restart=Never -- \
  curl -s -o /dev/null -w "%{http_code}\n" http://store-svc
```{{exec}}

Expected: output is `200`.
