# Well done!

You have completed the Docker Compose guided exercise. Here is what you practised:

**Step 1** — Wrote your first `docker-compose.yaml` and started a single Nginx service with `docker compose up -d`.

**Step 2** — Added a second service and observed how Compose registers service names as DNS hostnames, enabling inter-service communication without IP addresses.

**Step 3** — Attached a named volume to a Redis service and verified that data persisted after the container was destroyed and recreated.

**Step 4** — Segmented traffic using two bridge networks (`frontend` and `backend`), isolating Redis from the web server while keeping it reachable from the API.

**Step 5** — Combined `depends_on` with a `healthcheck` to guarantee that the API only starts once Redis is genuinely ready to accept connections.

## Key commands to remember

| Command | What it does |
|---|---|
| `docker compose up -d` | Start all services in detached mode |
| `docker compose ps` | Show service status |
| `docker compose logs <service>` | Stream logs for one service |
| `docker compose exec <service> sh` | Open a shell inside a service |
| `docker compose down` | Stop and remove containers and networks |
| `docker compose down -v` | Also remove named volumes |

## Next step

The advanced exercise asks you to build a similar stack independently, with a different set of services and constraints. Good luck!
