# Step 1 — The ephemeral problem

## What this step is about

By design, everything written inside a running container is stored in the container's writable layer. When the container is removed, that layer is destroyed — and so is all the data in it. This step lets you observe this behaviour directly.

---

## Build the image

Move into the working directory and build the image:

```
cd /root/app
docker build -t counter:v1 .
```

Watch the output. Docker executes each instruction in the Dockerfile and creates a layer for each one.

---

## Run the container and write some data

Start a container from the image and map port 5000 on the host to port 5000 inside the container:

```
docker run -d -p 5000:5000 --name counter1 counter:v1
```

Wait a moment for the application to start, then increment the counter three times:

```
curl http://localhost:5000/increment
curl http://localhost:5000/increment
curl http://localhost:5000/increment
```

Check the current count:

```
curl http://localhost:5000
```

The `visits` field should show **3**.

---

## Destroy the container and restart it

Stop and remove the container completely:

```
docker stop counter1
docker rm counter1
```

Start a brand-new container from the same image:

```
docker run -d -p 5000:5000 --name counter2 counter:v1
curl http://localhost:5000
```

---

> **Question:** what value does the `visits` field show now? Why?

Think about your answer — we will discuss it at the end of the exercise. Click **NEXT** to continue.
