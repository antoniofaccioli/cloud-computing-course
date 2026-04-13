# Step 5 — Service dependencies and healthchecks

`depends_on` controls **start-up order**, but it only waits for the container to start — not for the application inside it to be ready. A Redis container may be running but still initialising. A service that connects too early will fail.

The solution is to combine `depends_on` with a **healthcheck**: Compose will wait until the dependency service passes its health test before starting the dependent service.

## Update the Compose file

```
cat > /root/lab/docker-compose.yaml << 'EOF'
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    networks:
      - frontend

  api:
    image: traefik/whoami
    ports:
      - "8081:80"
    networks:
      - frontend
      - backend
    depends_on:
      cache:
        condition: service_healthy

  cache:
    image: redis:7-alpine
    volumes:
      - redisdata:/data
    networks:
      - backend
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s
      timeout: 3s
      retries: 5

volumes:
  redisdata:

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
EOF
```

The `healthcheck` on `cache` runs `redis-cli ping` every 5 seconds. Redis responds with `PONG` when ready. The `api` service uses `condition: service_healthy` — it will not start until Redis has passed at least one health check.

## Start the stack and observe the order

```
cd /root/lab && docker compose up
```

Run without `-d` this time so you can watch the output. You will see `cache` start first, pass its healthcheck, and only then see `api` start.

Press `Ctrl+C` to stop, then restart in detached mode:

```
docker compose up -d
```

## Inspect health status

```
docker compose ps
```

The `cache` service now shows a health status. Check the details:

```
docker inspect lab-cache-1 --format '{{json .State.Health.Status}}'
```

## Test the full stack

```
curl http://localhost:8080
```

```
curl http://localhost:8081
```

Both services respond correctly.

## Final cleanup

```
docker compose down -v
```

The `-v` flag also removes the `redisdata` volume, leaving the system clean.

Congratulations — you have built a complete multi-service Compose stack with volumes, network segmentation, and healthcheck-aware startup ordering.
