# Step 1 — Base file and development override

## Concept

Docker Compose supports **override files**. When you run `docker compose up`, Compose automatically reads two files in order:

1. `docker-compose.yaml` — the base configuration, environment-agnostic
2. `docker-compose.override.yaml` — local overrides, merged on top of the base

This pattern allows the base file to be committed to version control while the override contains developer-specific settings that stay local (and are listed in `.gitignore`).

## What you need to build

### The Dockerfile

Write a `Dockerfile` at `/root/app/Dockerfile` for the API service. It must:

- Use `python:3.11-slim` as the base image
- Install dependencies from `requirements.txt` before copying the full source (for cache efficiency)
- Expose port 5000
- Start the application with `python app.py`

### The base file: `docker-compose.yaml`

Write a base Compose file at `/root/app/docker-compose.yaml` with two services:

**api**
- Build from the local `Dockerfile`
- Set the environment variable `APP_ENV` to `production`
- Do **not** publish any ports — in the base configuration the API is internal only
- Connect it to a network called `appnet`

**db**
- Use `postgres:16-alpine`
- Set `POSTGRES_USER`, `POSTGRES_PASSWORD`, and `POSTGRES_DB` to values of your choice
- Mount a named volume for `/var/lib/postgresql/data`
- Add a healthcheck using `pg_isready`
- Connect it to `appnet`

Declare the volume and the network at the top level.

### The development override: `docker-compose.override.yaml`

Write an override file at `/root/app/docker-compose.override.yaml` that:

- Overrides `APP_ENV` to `development` on the `api` service
- Publishes port **5000** on the host for the `api` service
- Adds a bind mount that maps `/root/app` on the host to `/app` inside the `api` container (for live code reload during development)

## Verification

**With the override (development mode):**

Bring the stack up using the standard command (Compose merges the override automatically). Then verify:

1. `docker compose ps` shows both services running
2. A request to `http://localhost:5000` returns a JSON response where `"env"` is `"development"`
3. The api container has a bind mount visible in its mounts

**Without the override (simulating production):**

Bring the stack down, then start it again specifying **only** the base file explicitly (there is a flag for this). Then verify:

1. `http://localhost:5000` is **not** reachable from the host (the port is not published)
2. `docker compose ps` still shows both services running

Bring the stack down before moving to Step 2.

## Why this matters for the next step

Step 2 will modify `docker-compose.yaml` to use environment variable interpolation. If the file does not exist or the services are not correctly defined, Step 2 will have nothing to build on.
