# Step 2 — Inject the ConfigMap as environment variables

The pre-written `frontend-deployment.yaml` already references `app-config`. Apply it:

```bash
kubectl apply -f /root/frontend-deployment.yaml
kubectl apply -f /root/frontend-service.yaml
```{{exec}}

Wait for the Pods to be ready:

```{{exec}}bash
kubectl get pods -n lesson15 -w
```{{exec}}

Press `Ctrl+C` to stop watching once both Pods show `Running`.

Now exec into one of the frontend Pods and verify the environment variables are present:

```bash
POD=$(kubectl get pod -n lesson15 -l app=frontend -o jsonpath='{.items[0].metadata.name}')
kubectl exec $POD -n lesson15 -- env | grep -E "APP_ENV|LOG_LEVEL|MAX_CONNECTIONS"
```{{exec}}

You should see the three values from the ConfigMap injected as regular environment variables. The container process reads them exactly like any other env var — it has no knowledge of Kubernetes or ConfigMaps.

Note: if you update a ConfigMap value and the data was injected as an **env var**, the running Pod does **not** pick up the change — a restart is required. Mounted files behave differently, as you will see in the next step.
