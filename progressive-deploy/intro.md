# Progressive deploy — from Dockerfile to Compose

In this exercise you will build a two-service web stack from scratch, step by step.

## How this exercise works

Each step has two parts:

- **Part A (guided):** all commands are provided and explained. Follow them carefully.
- **Part B (your turn):** you are given the objective only. No commands. You must complete Part B before Part A of the next step will work — the next guided step depends on what you produce here.

If you skip a Part B and move to the next step, the commands will fail. That is by design.

## What you will build

- **frontend** — a Python/Flask web app that counts visits and stores them in a file
- **backend** — a Python/Flask API that logs requests and exposes them at `/api`

By the end you will have both services running together under Docker Compose, with named volumes for persistence, a shared network, a healthcheck, and a startup dependency.

## The files

The setup has already created two directories for you:

- `/root/frontend/` — contains `app.py`, `requirements.txt`, and a `Dockerfile`
- `/root/backend/` — contains `app.py`, `requirements.txt`, and a `Dockerfile`

Wait for the prompt to return, then start with Step 1A.
