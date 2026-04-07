# Exercise complete

**Cloud Computing and Distributed Systems**
Università degli Studi di Verona — A.A. 2025/2026

---

## What you have done

- Built a Docker image from a Dockerfile and ran the containerised application
- Observed how Docker's layer cache works when source code changes
- Compared two Dockerfiles — one with inefficient instruction order, one optimised
- Built a multi-stage image and compared its size against a single-stage image

---

## Key concepts to remember

**Layer caching** — place stable instructions (dependency installation) before volatile ones (application code) to maximise cache reuse and keep rebuild times short.

**Multi-stage builds** — separate the build environment from the runtime image. The final image contains only what is needed to run the application, nothing more.

---

## Commands used in this exercise

| Command | What it does |
|---|---|
| `docker build -t name:tag -f Dockerfile .` | Build an image |
| `docker images` | List local images and their sizes |
| `docker run -d -p host:container --name name image` | Run a container in the background |
| `docker ps` | List running containers |
| `curl http://localhost:5000` | Test the application |
| `docker stop name && docker rm name` | Stop and remove a container |

---

Bring your answer to the final question to the class debrief.
