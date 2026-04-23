# Step 3 — Pod phases

Watch the Pod you just created transition through its lifecycle phases. Run this command and keep it open:

```
kubectl get pod fixed-pod -w
```{{exec}}

You will see the `STATUS` column change. Wait until it reaches `Running`, then press `Ctrl+C` to stop watching.

Now query the phase directly from the Pod's status using a jsonpath expression:

```
kubectl get pod fixed-pod -o jsonpath='{.status.phase}'
```{{exec}}

Press Enter to get a clean new line after the output:

```
echo ""
```{{exec}}

The output is the exact string that Kubernetes uses internally to represent the Pod's current phase.

Also look at the full list of conditions:

```
kubectl get pod fixed-pod -o jsonpath='{.status.conditions[*].type}' && echo ""
```{{exec}}

> **Your instructor will now launch Kahoot question 3.**
> The answer is the value you saw in the phase output above.
