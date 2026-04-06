# Step 1 — Explore the environment

## Verify Docker is installed

```
docker --version
```

You should see the Docker version number. This confirms Docker is installed and the daemon is running.

---

## Explore the CLI

Docker organises its commands into logical groups. To see everything available:

```
docker help
```

The commands you will use in this scenario and in the exercises are:

| Command | What it does |
|---|---|
| `docker build` | Builds an image from a Dockerfile |
| `docker images` | Lists all images stored locally |
| `docker run` | Creates and starts a container from an image |
| `docker ps` | Lists running containers |
| `docker logs` | Shows the output produced by a container |
| `docker stop` | Stops a running container |
| `docker rm` | Removes a stopped container |
| `docker rmi` | Removes an image |

---

## Explore the working directory

The application files are already in place:

```
ls /root/
```

You will see `app.py` and `Dockerfile`. Read the Dockerfile:

```
cat /root/Dockerfile
```

This is the only file you need to understand — not the Python code.

---

When you are ready, click **NEXT**.
