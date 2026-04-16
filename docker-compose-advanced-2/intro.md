# Docker Compose advanced — multi-environment stack

This exercise covers three features of Docker Compose that are essential for managing real applications across different environments: **override files**, **environment variable interpolation**, and **service profiles**.

No commands are provided. You are expected to write all YAML and shell commands yourself, using `docker compose --help` and the chapter notes as references.

## The application

You will manage a two-service stack:

- **api** — a Python/Flask application already created at `/root/app/`
- **db** — a PostgreSQL 16 database

Over three steps you will evolve this stack to support development and production environments, externalise all configuration into `.env` files, and add optional services that can be activated on demand.

## Working directory

All files must be created in `/root/app`. Run all `docker compose` commands from that directory.

## What you need to build the api image

The source code is at `/root/app/app.py` and `/root/app/requirements.txt`. You will need to write a `Dockerfile` for the API as part of Step 1. The application listens on the port defined by the `API_PORT` environment variable (default: 5000).

## Prerequisites

Docker Compose v2 is being installed in the background. Wait for the prompt to return before starting.
