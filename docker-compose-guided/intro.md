# Docker Compose — Guided track

In the previous exercises you ran containers one at a time using `docker run`. In real applications, multiple containers need to cooperate: a web server talks to a backend, the backend talks to a database. Coordinating all of this by hand quickly becomes error-prone.

**Docker Compose** solves this problem by letting you describe your entire multi-service infrastructure in a single YAML file and start everything with one command.

## What you will build

Over five steps you will construct a complete Compose stack from scratch:

- A **web server** (Nginx) serving static content
- An **API service** (a lightweight HTTP responder)
- A **Redis** data store with a named volume for persistence
- **Two isolated networks** separating public and private traffic
- A **healthcheck** that ensures Redis is ready before the API starts

## Prerequisites

Docker and Docker Compose are being installed in the background. Wait for the prompt to return before starting Step 1.

> All commands in this exercise use `docker compose` (with a space) — the Compose v2 plugin bundled with Docker CE.
