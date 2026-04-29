# Lesson 15 — Exercise A: ConfigMaps, Secrets and Ingress

In this guided exercise you will build a complete configuration and exposure pipeline for a two-service application.

**What you will do:**

- Create a ConfigMap with non-sensitive configuration and inject it two ways: as environment variables and as a mounted file
- Observe that mounted files update live without restarting the Pod
- Create a Secret with sensitive credentials and inject it into a Deployment
- Install the Nginx Ingress Controller on the cluster
- Write an Ingress resource with path-based routing to expose both services through a single entry point
- Test everything with `curl`

**Environment:** a single-node Kubernetes cluster is running. The namespace `lesson15` has been created. All YAML manifests are pre-written in `/root/` — you will apply them step by step and observe what happens.
