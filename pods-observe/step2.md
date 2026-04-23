# Step 2 — What happens with a broken manifest?

Write a manifest with a deliberate indentation error — the `image` field is indented at the wrong level:

```
cat > /root/broken-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: broken-pod
spec:
  containers:
  - name: nginx
  image: nginx:1.25
EOF
```{{exec}}

Try to apply it:

```
kubectl apply -f /root/broken-pod.yaml
```{{exec}}

Read the error message carefully. It tells you exactly what is wrong and where.

Now fix the manifest — the `image` field must be indented to align with `name`:

```
cat > /root/fixed-pod.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: fixed-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.25
EOF
```{{exec}}

Apply the fixed version:

```
kubectl apply -f /root/fixed-pod.yaml
```{{exec}}

> **Your instructor will now launch Kahoot question 2.**
> Think about what the error message told you before answering.
