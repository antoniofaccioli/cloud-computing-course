# Step 8 — Create the Ingress resource

Apply the pre-written Ingress manifest with path-based routing: `/` goes to the frontend Service, `/api` goes to the api Service.

```bash
kubectl apply -f /root/app-ingress.yaml
```{{exec}}

Inspect the Ingress:

```bash
kubectl get ingress app-ingress -n lesson15
```{{exec}}

```bash
kubectl describe ingress app-ingress -n lesson15
```{{exec}}

The `Rules` section shows the routing table: host `myapp.local`, path `/` → `frontend:80`, path `/api` → `api:80`.

The Nginx Ingress Controller detects the new resource automatically via the Kubernetes API watch mechanism and updates its internal `nginx.conf` without restarting.

Verify by inspecting the nginx.conf inside the controller Pod:

```bash
kubectl exec -n ingress-nginx $(kubectl get pod -n ingress-nginx -l app.kubernetes.io/component=controller -o jsonpath='{.items[0].metadata.name}') -- cat /etc/nginx/nginx.conf | grep myapp
```{{exec}}

You should see `myapp.local` referenced in the generated Nginx configuration.
