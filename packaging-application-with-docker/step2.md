# Step 2 — Build and run the first image

## Build the image

Build the image using `Dockerfile.v1` and tag it as `myapp:v1`:

```
docker build -t myapp:v1 -f Dockerfile.v1 .
```

Watch the output. You will see Docker executing each instruction in order. Notice that it downloads the base image and then installs Flask — this takes a moment.

When the build finishes, list your local images:

```
docker images
```

Note the size of `myapp:v1`. You will compare it later.

---

## Run the container

Start a container from the image. The `-d` flag runs it in the background; `-p` maps port 5000 on the host to port 5000 inside the container:

```
docker run -d -p 5000:5000 --name myapp myapp:v1
```

Verify it is running:

```
docker ps
```

You should see `myapp` listed with status `Up`.

Test the application:

```
curl http://localhost:5000
```

You should receive a JSON response: `{"service": "Cloud Computing", "status": "running"}`.

---

## Stop and remove the container

```
docker stop myapp && docker rm myapp
```

---

> **Question before you continue:** the container responded correctly. What do you think would happen to that response if you stopped and removed the container without changing the image?

Click **NEXT**.
