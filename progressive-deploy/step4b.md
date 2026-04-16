# Step 4B — Add healthcheck and depends_on (your turn)

## Objective

Make the stack production-ready by ensuring the frontend only starts once the backend is genuinely healthy.

## What you need to do

Edit `/root/app/docker-compose.yaml` to add the following:

1. A `healthcheck` on the `backend` service that periodically calls `http://localhost:5000/health`. The backend already has a `/health` endpoint that returns `{"status": "ok"}`. Use `CMD-SHELL` with `wget -qO- http://localhost:5000/health` as the test command. Set a reasonable interval, timeout, and number of retries.

2. A `depends_on` entry on the `frontend` service that waits for `backend` to reach `condition: service_healthy` before starting.

3. Bring the stack down and back up:

   ```
   cd /root/app && docker compose down
   ```

   ```
   docker compose up -d
   ```

4. Verify that `docker compose ps` shows the `backend` service with a `healthy` status.

5. Check the startup order using timestamps:

   ```
   docker compose logs --timestamps backend frontend
   ```

   The backend log entries should appear before the frontend log entries — confirming that the frontend waited for the backend to be healthy.

## Final cleanup

When you are satisfied, tear everything down including volumes:

```
cd /root/app && docker compose down -v
```

```
docker volume rm frontdata backdata 2>/dev/null || true
```

```
docker network rm appnet 2>/dev/null || true
```
