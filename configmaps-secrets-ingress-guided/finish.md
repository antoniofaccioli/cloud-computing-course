# Exercise A complete

You have built a complete configuration and exposure pipeline:

- A **ConfigMap** injected as environment variables and as a mounted file, with live update verified
- A **Secret** with encrypted credentials injected into a Deployment
- An **Nginx Ingress Controller** installed in baremetal/NodePort mode
- An **Ingress resource** with path-based routing exposing two services through a single entry point

This is the standard pattern for any production Kubernetes workload: configuration decoupled from the image, sensitive data protected at the infrastructure level, and external traffic controlled by a single Ingress.

In Exercise B you will extend this setup autonomously.
