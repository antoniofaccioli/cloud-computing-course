# Pods — init container and sidecar (advanced)

A Kubernetes cluster is already running.

In Exercise A you wrote Pod manifests with two containers sharing an `emptyDir` volume. You used `kubectl apply`, `kubectl exec -c`, and `kubectl logs -c`.

This exercise builds directly on those skills. You will write a single manifest that combines three containers working together — an init container, a main container, and a sidecar — all sharing the same volume.

No commands are provided. Use what you practised in Exercise A.

Confirm the cluster is ready:

```
kubectl get nodes
```{{exec}}
