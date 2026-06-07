## Step 4 — Inspect Driver and Executor Pods

Once the job completes, check the Driver Pod status:

```
kubectl get pods
```{{exec}}

Get the Driver Pod logs to see the job output:

```
kubectl logs spark-driver
```{{exec}}

You should see the revenue aggregation table printed by the PySpark job. Look for the `=== Revenue by category (broadcast join) ===` header.

Describe the Driver Pod to see how Kubernetes scheduled it:

```
kubectl describe pod spark-driver
```{{exec}}

Notice the `serviceAccountName: spark-sa` field confirming that the RBAC configuration was applied. The Executor Pods were created and deleted automatically during job execution — Kubernetes managed their full lifecycle without any manual intervention.

Clean up the Driver Pod:

```
kubectl delete pod spark-driver
```{{exec}}
