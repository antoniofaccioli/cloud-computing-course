# Step 6 — Creating a Pod and observing its lifecycle

Now create a simple Pod and observe the exact lifecycle described in the lesson.

Create a Pod running nginx:

```
kubectl run webserver --image=nginx:alpine
```{{exec}}

Immediately check its status:

```
kubectl get pod webserver
```{{exec}}

You may catch it in `Pending` or `ContainerCreating` state — this is Step 2 (etcd write) and Step 3 (Scheduler placement) happening in real time. Run the command again if you see `ContainerCreating`:

```
kubectl get pod webserver
```{{exec}}

Once the status is `Running`, get the full details:

```
kubectl describe pod webserver
```{{exec}}

Scroll to the **Events** section at the bottom. You will see the exact sequence from the lesson:

1. `Scheduled` — the Scheduler selected this node
2. `Pulling` — the kubelet asked the container runtime to pull the image
3. `Pulled` — the image was downloaded
4. `Created` — the container was created
5. `Started` — the container process started

---

Verify the Pod is serving content:

```
kubectl exec webserver -- wget -qO- http://localhost
```{{exec}}

You should see the nginx default HTML page — the container is running and healthy.
