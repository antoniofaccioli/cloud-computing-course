## Step 1 — Build and push the Spark image

The Dockerfile in `/root/spark-app/` extends the official `spark:python3` image by copying the PySpark job script into the container. This is the standard pattern: application code is baked into the image so the Driver Pod can find it at `local:///opt/spark/work-dir/job.py`.

Build the image:

```
docker build -t localhost:5000/spark-app:latest /root/spark-app/
```{{exec}}

Push it to the local registry:

```
docker push localhost:5000/spark-app:latest
```{{exec}}

Verify the image is available in the registry:

```
curl -s http://localhost:5000/v2/spark-app/tags/list
```{{exec}}

You should see `{"name":"spark-app","tags":["latest"]}`. The local registry acts as a bridge between Docker and Kubernetes: containerd pulls from it using the standard OCI protocol, without any `docker save` or `ctr import` steps.
