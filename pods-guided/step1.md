# Step 1 — Write and apply your first Pod manifest

A Pod manifest is a YAML file that describes the desired state of a Pod. Every manifest requires four fields: `apiVersion`, `kind`, `metadata`, and `spec`.

Create the manifest:

```
cat > /root/nginx-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
EOF
```{{exec}}

Read the file back to confirm it was written correctly:

```
cat /root/nginx-pod.yaml
```{{exec}}

Apply the manifest to the cluster:

```
kubectl apply -f /root/nginx-pod.yaml
```{{exec}}

The output should be:

```
pod/nginx-pod created
```

Check that the Pod has been accepted and is starting:

```
kubectl get pod nginx-pod
```{{exec}}

The `STATUS` column will show `ContainerCreating` while the node pulls the image, then `Running` when the container has started. Run the command again after a few seconds if needed:

```
kubectl get pod nginx-pod
```{{exec}}

**What just happened?** You sent the manifest to the API Server. It validated the YAML, stored the desired state in etcd, and marked the Pod as `Pending`. The Scheduler assigned it to the only available node. The kubelet on that node pulled the image and started the container.
