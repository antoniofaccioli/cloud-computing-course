# Step 6 — Inject the Secret into a Deployment

The pre-written `api-deployment.yaml` references the Secret you just created. Apply it:

```bash
kubectl apply -f /root/api-deployment.yaml
kubectl apply -f /root/api-service.yaml
```{{exec}}

Wait for the api Pod to be ready:

```bash
kubectl wait deployment api -n lesson15 --for=condition=Available --timeout=60s
```{{exec}}

Exec into the api Pod and verify the Secret values are available as environment variables:

```bash
POD=$(kubectl get pod -n lesson15 -l app=api -o jsonpath='{.items[0].metadata.name}')
kubectl exec $POD -n lesson15 -- env | grep DB_
```{{exec}}

The values appear **decoded** inside the container. The application process sees `s3cr3tP@ss`, not the Base64 string. The encoding is transparent to the running application.

Check the current state of the namespace — all resources so far:

```bash
kubectl get all -n lesson15
```{{exec}}

You have a frontend Deployment (2 replicas) and an api Deployment (1 replica), each with a ClusterIP Service. Neither is reachable from outside the cluster yet. That is what the Ingress is for.
