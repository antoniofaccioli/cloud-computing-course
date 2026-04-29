# Step 3 — Add a host-based Ingress rule

**Objective:** extend the existing Ingress `app-ingress` in namespace `lesson15` to add a host-based rule for `dashboard.local` that routes all traffic to the `dashboard` Service.

**What you need to do:**

- Edit or replace the Ingress `app-ingress` to add a second `rules` entry for host `dashboard.local`, routing path `/` (Prefix) to `dashboard:80`
- Keep the existing `myapp.local` rules intact

**Verify:**

- A request with `Host: myapp.local` to `/` returns 200 (frontend — unchanged)
- A request with `Host: dashboard.local` to `/` returns 200 (dashboard)
- A request with `Host: dashboard.local` to `/api` returns 404 (no such rule for this host)
- Both hosts are served through the same NodePort

---

### Command hints

Edit the Ingress resource directly:
```
kubectl edit ingress app-ingress -n lesson15
```

Or apply an updated YAML file:
```
kubectl apply -f ingress.yaml
```

Inspect the Ingress routing table after the update:
```
kubectl describe ingress app-ingress -n lesson15
```

Get the NodePort and node IP for testing:
```
kubectl get svc ingress-nginx-controller -n ingress-nginx
kubectl get nodes -o wide
```

Test with curl using a custom Host header:
```
curl -s -o /dev/null -w "%{http_code}" -H "Host: dashboard.local" http://<NODE_IP>:<NODEPORT>/
```
