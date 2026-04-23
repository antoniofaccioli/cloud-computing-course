# Well done

You have completed the guided Pod exercise. Here is what you have practised:

- Writing a Pod manifest with the four required fields: `apiVersion`, `kind`, `metadata`, `spec`
- Applying a manifest with `kubectl apply -f` and inspecting the result with `kubectl get` and `kubectl describe`
- Reading logs with `kubectl logs` and opening a shell with `kubectl exec`
- Creating a multi-container Pod where two containers share an `emptyDir` volume
- Targeting a specific container with the `-c` flag in `logs` and `exec`
- Observing that bare Pods have no self-healing

The next exercise uses the same cluster. You will apply the sidecar pattern to build a Pod where one container forwards the logs produced by another.
