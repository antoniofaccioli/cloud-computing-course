# Step 3 — A Pod with two containers sharing a volume

A Pod can contain more than one container. All containers in the same Pod share the same network namespace and can share storage volumes.

In this step you will create a two-container Pod:
- **nginx**: serves files from `/usr/share/nginx/html`
- **writer**: runs a loop that writes the current timestamp to `/html/index.html` every two seconds

Both containers mount the same `emptyDir` volume, so the file written by `writer` is immediately visible to `nginx`.

Delete the previous Pod first:

```
kubectl delete pod nginx-pod
```{{exec}}

Create the new two-container manifest:

```
cat > /root/shared-volume-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: shared-volume-pod
spec:
  volumes:
  - name: html
    emptyDir: {}
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
  - name: writer
    image: busybox:1.36
    volumeMounts:
    - name: html
      mountPath: /html
    command: ["/bin/sh", "-c"]
    args:
    - while true; do date > /html/index.html; sleep 2; done
EOF
```{{exec}}

Apply it:

```
kubectl apply -f /root/shared-volume-pod.yaml
```{{exec}}

Wait for both containers to be ready. The `READY` column shows `2/2` when both are running:

```
kubectl get pod shared-volume-pod
```{{exec}}

Run the command again if not yet `2/2`:

```
kubectl get pod shared-volume-pod
```{{exec}}

Check the logs of the `writer` container — it has no output because it only writes to a file:

```
kubectl logs shared-volume-pod -c writer
```{{exec}}

Open a shell into the `nginx` container and read the file that `writer` is updating:

```
kubectl exec -it shared-volume-pod -c nginx -- /bin/bash
```{{exec}}

```
cat /usr/share/nginx/html/index.html
```{{exec}}

Run `cat` again after a couple of seconds and observe that the content has changed:

```
cat /usr/share/nginx/html/index.html
```{{exec}}

```
exit
```{{exec}}

**Key observation:** the `-c nginx` flag specifies which container to exec into. Without it, kubectl would default to the first container in the spec. When a Pod has multiple containers, you must always specify `-c <container-name>` for `logs` and `exec`.

Now open a shell into the `writer` container and verify you can see the same file from there:

```
kubectl exec -it shared-volume-pod -c writer -- /bin/sh
```{{exec}}

```
cat /html/index.html
```{{exec}}

```
exit
```{{exec}}

Both containers access the same file through different mount paths — `/usr/share/nginx/html/index.html` for nginx, `/html/index.html` for writer. This is the shared `emptyDir` volume in action.
