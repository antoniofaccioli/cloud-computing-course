# Step 3 — The scheduler at work

Inspect the scheduler pod:

```
kubectl describe pod -n kube-system -l component=kube-scheduler
```{{exec}}

In the output, find the **Command** section. It lists the flags the scheduler was started with.

Now create a Pod and watch what the scheduler does:

```
kubectl run testpod --image=nginx:alpine
```{{exec}}

```
kubectl describe pod testpod
```{{exec}}

Scroll to the **Events** section. Find the line that says `Scheduled` and read which component is responsible — it will be listed in the `From` column.

