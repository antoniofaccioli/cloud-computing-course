## Spark on Kubernetes — Guided exercise

In this exercise you will submit a PySpark job natively to the Kubernetes cluster using `spark-submit --master k8s://`. The job runs a broadcast join and aggregates revenue by product category.

The environment already has:
- A running Kubernetes cluster (single node, kubeadm)
- Docker available for building images
- A local registry running on `localhost:5000`
- The application files in `/root/spark-app/`

Verify the cluster is ready:

```
kubectl get nodes
```{{exec}}
