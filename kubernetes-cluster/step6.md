# Step 6 — Pod events

The Pod you created in Step 3 should now be running. Describe it again and focus on the Events section:

```
kubectl describe pod testpod
```{{exec}}

Scroll to the bottom and read the **Events** table. The events appear in chronological order and show exactly what happened after the Pod was created:

1. `Scheduled` — the Scheduler chose this node
2. `Pulling` — the kubelet asked the container runtime to download the image
3. `Pulled` — the image download completed
4. `Created` — the container was created
5. `Started` — the container process started

Identify which event appears **immediately after** `Scheduled`.

