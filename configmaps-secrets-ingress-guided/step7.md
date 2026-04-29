# Step 7 — Install the Nginx Ingress Controller

An Ingress resource on its own does nothing — it only stores routing rules. The **Ingress Controller** is the component that reads those rules and enforces them as a reverse proxy.

Install the Nginx Ingress Controller using the official baremetal manifest:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/baremetal/deploy.yaml
```{{exec}}

Wait for the controller Pod to be ready:

```bash
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
```{{exec}}

Verify the controller is running:

```bash
kubectl get pods -n ingress-nginx
```{{exec}}

Find the NodePort assigned to the controller:

```bash
kubectl get svc ingress-nginx-controller -n ingress-nginx
```{{exec}}

Note the port in the `80:3XXXX/TCP` column — this is the NodePort you will use to reach the Ingress. Save it:

```bash
echo "NodePort: $(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')"
```{{exec}}

Get the node's internal IP:

```bash
echo "Node IP: $(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')"
```{{exec}}

A request to `http://NODE_IP:NODEPORT` reaches the Ingress Controller. Without routing rules it returns 404. The next step adds them.
