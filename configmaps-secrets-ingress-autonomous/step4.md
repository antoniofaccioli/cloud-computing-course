# Step 4 — Command reference

Use this page as a reference if you need a reminder on syntax or commands. No objectives here — consult it freely at any point during the exercise.

---

## ConfigMap

Create from literals:
```bash
kubectl create configmap <name> --from-literal=KEY=value -n lesson15
```{{exec}}

Create from a file:
```{{exec}}bash
kubectl create configmap <name> --from-file=filename.conf -n lesson15
```{{exec}}

Inspect:
```bash
kubectl get configmap <name> -n lesson15 -o yaml
```{{exec}}

Update a key (patch):
```{{exec}}bash
kubectl patch configmap <name> -n lesson15 --type merge -p '{"data":{"KEY":"new-value"}}'
```{{exec}}

---

## Secret

Create from literals:
```bash
kubectl create secret generic <name> --from-literal=KEY=value -n lesson15
```{{exec}}

Inspect (values are Base64):
```{{exec}}bash
kubectl get secret <name> -n lesson15 -o yaml
```{{exec}}

Decode a value:
```bash
kubectl get secret <name> -n lesson15 -o jsonpath='{.data.KEY}' | base64 -d
```{{exec}}

---

## Deployment with ConfigMap as volume

```{{exec}}yaml
spec:
  containers:
  - name: myapp
    image: nginx:alpine
    volumeMounts:
    - name: config-vol
      mountPath: /etc/myapp/
  volumes:
  - name: config-vol
    configMap:
      name: <configmap-name>
```

---

## Ingress with two host rules

```yaml
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
  - host: dashboard.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: dashboard
            port:
              number: 80
```

Apply with:
```bash
kubectl apply -f ingress.yaml
```{{exec}}

---

## Test with curl (no real DNS)

Get NodePort and node IP:
```{{exec}}bash
NODEPORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx \
  -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
echo "$NODE_IP:$NODEPORT"
```{{exec}}

Test a specific host and path:
```bash
curl -s -o /dev/null -w "%{http_code}" -H "Host: dashboard.local" http://$NODE_IP:$NODEPORT/
```{{exec}}

---

## Useful kubectl commands

```{{exec}}bash
kubectl get all -n lesson15
```{{exec}}

```bash
kubectl get ingress -n lesson15
```{{exec}}

```{{exec}}bash
kubectl describe ingress app-ingress -n lesson15
```{{exec}}

```bash
kubectl exec <pod-name> -n lesson15 -- ls /etc/myapp/
```{{exec}}

```{{exec}}bash
kubectl exec <pod-name> -n lesson15 -- cat /etc/myapp/config.json
```{{exec}}

```bash
kubectl get pods -n lesson15
```{{exec}}
