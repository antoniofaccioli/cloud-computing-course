# Docker Compose — Advanced track

In this exercise you will design and build a multi-service Compose stack from scratch. Unlike the guided exercise, no commands are provided — only the objectives and the constraints.

You are expected to write the `docker-compose.yaml` yourself, choose the right directives, and verify that each goal is met.

## The application

You will build a three-tier web stack:

- **db** — a PostgreSQL database with a named volume for data persistence
- **api** — a lightweight HTTP service (`traefik/whoami`) that represents the application backend
- **proxy** — an Nginx reverse proxy that routes external traffic to the API

## Working directory

Your working directory is `/root/app`. All files should be created there.

## Prerequisites

Docker Compose v2 is being installed in the background. Wait for the prompt to return before starting Step 1.

> You have all the tools you need. When in doubt, `docker compose --help` and `docker compose <command> --help` are your references.
