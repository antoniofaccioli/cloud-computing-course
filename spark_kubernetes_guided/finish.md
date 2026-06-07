## Exercise complete

You have submitted a PySpark job natively to Kubernetes using `spark-submit --master k8s://`. The key steps were:

- The application code was baked into a Docker image and pushed to a local registry
- A ServiceAccount with RBAC permissions allowed the Driver Pod to manage Executor Pods
- Kubernetes created and deleted all Pods automatically — no long-running Spark cluster required

This is the production pattern: a CI/CD pipeline builds and pushes the image, then invokes `spark-submit` against the cluster API. The cluster handles scheduling, bin-packing, and cleanup.
