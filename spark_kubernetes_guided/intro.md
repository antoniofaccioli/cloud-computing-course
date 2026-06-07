## Spark on Kubernetes — Guided exercise

In this exercise you will submit a PySpark job natively to the Kubernetes cluster using `spark-submit --master k8s://`. The job runs a broadcast join and aggregates revenue by product category.

The environment setup (running in the background) installs:
- Apache Spark on the host so `spark-submit` is available directly
- A local Docker registry on `localhost:5000`
- The application files in `/root/spark-app/`

Verify the cluster is ready:

```
kubectl get nodes
```{{exec}}
