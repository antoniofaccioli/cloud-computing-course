# Exercise B complete

You have autonomously extended a running Kubernetes cluster with:

- A third service with a dedicated ConfigMap mounted as a configuration file
- A verified live update of a volume-mounted ConfigMap — no Pod restart required
- A host-based Ingress rule added to an existing Ingress resource, tested without real DNS

The cluster now serves three services (`frontend`, `api`, `dashboard`) through a single Nginx Ingress Controller on a single NodePort — exactly the pattern used in production environments to minimise external entry points.
