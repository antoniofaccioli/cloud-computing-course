# Objectives

Complete each objective in order. Do not move to the next until you have verified the current one.

---

**Objective 1 — Create a Deployment**

Create a Deployment named `store-deployment` with the following characteristics:
- Image: `httpd:2.4`
- 3 replicas
- Label: `app: store`
- RollingUpdate strategy with `maxSurge: 1` and `maxUnavailable: 0`

Verify: all 3 Pods are `Running` and the Deployment shows `READY 3/3`.

---

**Objective 2 — Expose with a NodePort Service**

Create a Service named `store-svc` that:
- Selects Pods with label `app: store`
- Listens on port `80`
- Forwards traffic to port `80` on the Pods
- Exposes node port `30090`

Verify: `curl http://<NodeIP>:30090` returns an HTTP 200 response.

---

**Objective 3 — Scale up**

Scale `store-deployment` to 5 replicas.

Verify: the Service Endpoints list shows 5 Pod IPs.

---

**Objective 4 — Perform a rolling update**

Update the container image to `httpd:2.4.58`.

Verify: all Pods are running the new image and the rollout completed successfully.

---

**Objective 5 — Roll back**

Roll back to the previous revision.

Verify: all Pods are running `httpd:2.4` again and the revision history shows a new entry.

---

**Objective 6 — Verify internal DNS resolution**

Launch a temporary debug Pod and verify that `store-svc` resolves correctly via CoreDNS
and returns an HTTP 200 response using the Service DNS name.
