## Step 2 — Configure RBAC

The Spark Driver Pod needs permission to create and delete Executor Pods during the job. This requires a ServiceAccount bound to a Role with the necessary permissions.

The RBAC manifest is already prepared in `/root/spark-app/rbac.yaml`. Inspect it:

```
cat /root/spark-app/rbac.yaml
```{{exec}}

Apply it:

```
kubectl apply -f /root/spark-app/rbac.yaml
```{{exec}}

Verify the ServiceAccount exists:

```
kubectl get serviceaccount spark-sa
```{{exec}}

Verify the RoleBinding is in place:

```
kubectl get rolebinding spark-rolebinding
```{{exec}}

Without this ServiceAccount, the Driver Pod would receive a 403 Forbidden error when calling the Kubernetes API to create Executor Pods. The job would start and immediately fail.
