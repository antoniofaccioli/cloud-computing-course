# Well done!

You have completed the Docker Compose advanced exercise.

## What you practised

**Step 1 — Override files**

You separated base configuration from environment-specific overrides. The base file defines the production-grade stack with no exposed ports; the override adds developer conveniences like port publishing and bind mounts. Running `docker compose up` merges both automatically; specifying only the base file with `-f` simulates production locally.

**Step 2 — Environment variable interpolation**

You externalised all configuration — credentials, ports, environment names — into `.env` files. The same `docker-compose.yaml` now drives both development and production by swapping the env file at startup time. No secrets are hardcoded in the YAML.

**Step 3 — Service profiles**

You added optional services that are invisible to normal `docker compose up` and only appear when explicitly activated with `--profile`. This prevents development tools from accidentally running in production and keeps the default stack lean.

## The pattern you have built

```
docker compose up -d                          # dev stack, default .env
docker compose -f docker-compose.yaml up -d   # base only, no override
docker compose --env-file .env.production up  # production config
docker compose --profile tools up -d          # + admin tools
docker compose --profile tools --profile cache up -d  # full stack
```

Five variants of the same application, driven by a single `docker-compose.yaml` and its companions — no duplication, no hardcoded values.
