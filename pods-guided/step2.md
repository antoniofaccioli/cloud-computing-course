# Step 2 — Inspect the running Pod

Now that the Pod is running, explore what Kubernetes knows about it.

Get a wider view including the node and Pod IP:

```
kubectl get pod nginx-pod -o wide
```{{exec}}

Note the `IP` column — this is the Pod's IP address inside the cluster network.

Get a detailed description of the Pod including its full lifecycle events:

```
kubectl describe pod nginx-pod
```{{exec}}

Scroll through the output and find the `Events` section at the bottom. You will see the exact sequence: `Scheduled` → `Pulled` → `Created` → `Started`. This is the lifecycle of a Pod creation you studied in class.

Read the container logs. Since Nginx has just started and received no requests, the access log will be empty, but the error log will show startup messages:

```
kubectl logs nginx-pod
```{{exec}}

Open an interactive shell inside the running container:

```
kubectl exec -it nginx-pod -- /bin/bash
```{{exec}}

From inside the container, check the Nginx process and the network interface:

```
ps aux | grep nginx
```{{exec}}

```
hostname
```{{exec}}

```
exit
```{{exec}}

**Observation:** the hostname inside the container is the Pod name. This is because the container inherits the Pod's network namespace, and the Pod's hostname is set to its name.
