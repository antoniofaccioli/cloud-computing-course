# Step 4 — Manage the container lifecycle

## Run a container in the background

So far the container ran in the foreground and exited immediately. Use `-d` (detached) to run a long-lived container in the background. Since our app exits immediately, we simulate a long-running process with a shell loop:

```
docker run -d --name background demo:v1 sh -c "while true; do sleep 10; done"
```

---

## Verify it is running

```
docker ps
```

You will see `background` with status `Up`.

---

## Inspect the container

```
docker inspect background
```

This returns detailed information about the container in JSON format: its configuration, network settings, mounts, and state. Use it when you need to understand exactly how a container is configured.

---

## Stop the container

```
docker stop background
```

`docker stop` sends a termination signal to the container and waits for it to shut down gracefully.

Verify:

```
docker ps -a
```

The container is now `Exited`.

---

## Remove the container and the image

Remove the stopped container:

```
docker rm background
```

Remove the image:

```
docker rmi demo:v1
```

Verify both are gone:

```
docker ps -a
docker images
```

---

## Summary of the commands

| Command | Usage |
|---|---|
| `docker build -t name:tag .` | Build an image |
| `docker images` | List local images |
| `docker run --name name image` | Run a container (foreground) |
| `docker run -d --name name image` | Run a container (background) |
| `docker run --rm image` | Run and auto-remove on exit |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers including stopped |
| `docker logs name` | Show container output |
| `docker inspect name` | Show full container details |
| `docker stop name` | Stop a running container |
| `docker rm name` | Remove a stopped container |
| `docker rmi name:tag` | Remove an image |

---

When you are ready, click **NEXT** to see the final summary.
