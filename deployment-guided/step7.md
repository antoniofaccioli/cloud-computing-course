# Step 7 — Create a ClusterIP Service

Pods have ephemeral IP addresses. Every time a Pod is replaced — by a rolling update, a
self-healing action, or a reschedule — its IP changes. A Service solves this by providing
a stable virtual IP and a DNS name that never changes.

The Service manifest has already been prepared. Inspect it:

```
cat /root/web-service.yaml
```

The `selector: app: web` field tells the Service to route traffic to all Pods with the label
`app: web`. The `port: 80` is what the Service listens on; `targetPort: 80` is the port
on the Pod container.

Apply the Service:

```
kubectl apply -f /root/web-service.yaml
```

Inspect the Service:

```
kubectl get service web-svc
```

Note the `CLUSTER-IP` column — this is the stable virtual IP assigned to the Service.
It will not change even as Pods are replaced.

List the Endpoints — the actual Pod IPs behind the Service:

```
kubectl get endpoints web-svc
```

You should see three IP addresses, one for each Pod replica.
