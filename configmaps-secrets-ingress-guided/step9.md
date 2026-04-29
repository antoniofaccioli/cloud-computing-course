# Step 9 — Test path-based routing

There is no real DNS for `myapp.local` in this environment. Use the `-H "Host:"` flag to simulate the hostname.

Save the NodePort and node IP into variables:

```bash
export NODEPORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')
```{{exec}}

```bash
export NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
```{{exec}}

```bash
echo "$NODE_IP:$NODEPORT"
```{{exec}}

Test the frontend path:

```bash
curl -s -o /dev/null -w "%{http_code}" -H "Host: myapp.local" http://$NODE_IP:$NODEPORT/
```{{exec}}

Test the api path:

```bash
curl -s -o /dev/null -w "%{http_code}" -H "Host: myapp.local" http://$NODE_IP:$NODEPORT/api
```{{exec}}

Both should return `200`. Try a path with no matching rule:

```bash
curl -s -o /dev/null -w "%{http_code}" -H "Host: myapp.local" http://$NODE_IP:$NODEPORT/unknown
```{{exec}}

This returns `404` from the Nginx default backend — no rule matches `/unknown`.

Finally, a request without the correct Host header also gets 404:

```bash
curl -s -o /dev/null -w "%{http_code}" http://$NODE_IP:$NODEPORT/
```{{exec}}

This is path-based and host-based routing in action: the single NodePort serves multiple path prefixes through one Ingress Controller.
