# Step 1 — What does the API say about a Pod?

Kubernetes exposes the full schema of every resource type via `kubectl explain`. Run this command:

```
kubectl explain pod
```{{exec}}

Read the output. You will see the four top-level fields: `apiVersion`, `kind`, `metadata`, `spec`.

Now go one level deeper into the `spec`:

```
kubectl explain pod.spec
```{{exec}}

Find the field `containers` and read its description. Note whether it is marked as required or optional.

Now look inside a single container definition:

```
kubectl explain pod.spec.containers
```{{exec}}

Find the `name` and `image` fields. Read their descriptions carefully.

> **Your instructor will now launch Kahoot question 1.**
> Look at the output above before answering.
