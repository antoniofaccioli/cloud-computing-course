# Step 8 — Create the Ingress resource

Create an Ingress with path-based routing: `/` goes to the frontend Service, `/api` goes to the api Service.

```bash
cat << 'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: lesson15
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api
            port:
              number: 80
EOF
```{{exec}}

Inspect the Ingress:

```{{exec}}bash
kubectl get ingress app-ingress -n lesson15
```{{exec}}

```bash
kubectl describe ingress app-ingress -n lesson15
```{{exec}}

The `Rules` section shows the routing table: host `myapp.local`, path `/` → `frontend:80`, path `/api` → `api:80`.

The Nginx Ingress Controller detects the new resource automatically via the Kubernetes API watch mechanism and updates its internal `nginx.conf` without restarting.
