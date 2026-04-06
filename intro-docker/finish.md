# Summary

**Cloud Computing and Distributed Systems — Lesson 8**

---

## What you have practised

- Verifying a Docker installation and exploring the CLI
- Building an image with `docker build` and tagging it
- Observing the layer cache: what gets reused and what gets invalidated
- Running containers in foreground and background
- Reading container output with `docker logs`
- Inspecting container details with `docker inspect`
- Managing the full lifecycle: `docker stop`, `docker rm`, `docker rmi`

---

## Commands reference

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

You are now ready for the exercises. Your instructor will provide the links.
