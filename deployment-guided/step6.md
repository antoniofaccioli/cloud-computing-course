# Step 6 — Execute a rollback

Imagine the `nginx:1.25` update introduced a problem. We need to revert to the previous version.
Kubernetes performs the rollback as another rolling update — the same availability guarantees apply.

Roll back to the previous revision:

```
kubectl rollout undo deployment/web-deployment
```

Watch the rollback progress:

```
kubectl rollout status deployment/web-deployment
```

Once complete, verify the image has reverted to `nginx:1.14`:

```
kubectl describe pods -l app=web | grep Image:
```

Check the revision history again:

```
kubectl rollout history deployment/web-deployment
```

Notice that revision 1 has disappeared and a new revision 3 has appeared.
Kubernetes does not restore the old revision in place — it reuses the old Pod template and
creates a new revision entry. What was revision 1 is now revision 3.

To roll back to a specific revision (not just the previous one), use `--to-revision`:

```
kubectl rollout undo deployment/web-deployment --to-revision=2
```

```
kubectl rollout status deployment/web-deployment
```

```
kubectl describe pods -l app=web | grep Image:
```

The Pods should now be running `nginx:1.25` again.
