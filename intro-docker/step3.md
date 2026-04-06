# Step 3 — Run and inspect a container

## Run the container

Start a container from the image you just built:

```
docker run --name mycontainer demo:v1
```

The container runs, executes the Python script, and exits. This is expected — the application is not a server, it runs once and terminates.

---

## List containers

`docker ps` shows only **running** containers. Since the container has already exited, use the `-a` flag to see all containers including stopped ones:

```
docker ps -a
```

You will see `mycontainer` with status `Exited`.

---

## Read the output

```
docker logs mycontainer
```

This shows everything the container printed to standard output while it was running.

---

## Remove the container

A stopped container still occupies space until explicitly removed:

```
docker rm mycontainer
```

Verify it is gone:

```
docker ps -a
```

---

## Run without keeping the container

The `--rm` flag tells Docker to remove the container automatically when it exits:

```
docker run --rm demo:v1
```

After the container exits, `docker ps -a` will show nothing — the container was removed automatically.

---

When you are ready, click **NEXT**.
