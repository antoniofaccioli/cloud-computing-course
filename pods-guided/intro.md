# Pods — guided track

A Kubernetes cluster is already running. You have a single node that acts as both control plane and worker.

In this exercise you will write Pod manifests from scratch, apply them to the cluster, and explore two fundamental properties of Pods: **shared network namespace** and **shared storage volumes**.

Every command is provided and explained. Read each explanation before running the command.

Verify the cluster is ready:

```
kubectl get nodes
```{{exec}}

You should see one node in `Ready` state before proceeding.
