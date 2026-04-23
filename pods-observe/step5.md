# Step 5 — Targeting containers in exec and logs

Create a two-container Pod:

```
cat > /root/two-container-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: two-container-pod
spec:
  volumes:
  - name: shared
    emptyDir: {}
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: shared
      mountPath: /usr/share/nginx/html
  - name: writer
    image: busybox:1.36
    volumeMounts:
    - name: shared
      mountPath: /data
    command: ["/bin/sh", "-c"]
    args:
    - while true; do date | tee /data/index.html; sleep 2; done
EOF
```{{exec}}

```
kubectl apply -f /root/two-container-pod.yaml
```{{exec}}

Wait for `READY 2/2`:

```
kubectl get pod two-container-pod
```{{exec}}

Now try to get logs without specifying a container:

```
kubectl logs two-container-pod
```{{exec}}

Read the error message carefully. Kubernetes tells you exactly what it needs.

Now specify the container explicitly:

```
kubectl logs two-container-pod -c nginx
```{{exec}}

```
kubectl logs two-container-pod -c writer
```{{exec}}

The `nginx` container logs are empty — nginx writes access logs to a file, not stdout, unless requests arrive. The `writer` container logs show the timestamps it is writing, because `tee` sends output to both the file and stdout.

Try exec without `-c`:

```
kubectl exec -it two-container-pod -- /bin/sh
```{{exec}}

Note which container you land in. Type `exit` to leave:

```
exit
```{{exec}}

Now exec into the second container explicitly:

```
kubectl exec -it two-container-pod -c writer -- /bin/sh
```{{exec}}

```
cat /data/index.html
```{{exec}}

```
exit
```{{exec}}

> **Your instructor will now launch Kahoot question 5.**
> Think about what happened when you omitted `-c` before answering.
