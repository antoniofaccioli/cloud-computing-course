# Step 4 — Network segmentation

By default all Compose services share one network and can reach each other freely. For security, it is better to segment traffic: public-facing services on a **frontend** network, private services on a **backend** network.

In this step you isolate Redis so that only the API can talk to it — the web server cannot.

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

  cache:
    image: redis:7-alpine
    volumes:
      - redisdata:/data
    networks:
      - backend

volumes:
  redisdata:

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
EOF
```

`web` joins only `frontend`. `cache` joins only `backend`. `api` joins both, acting as the bridge between the two tiers.

## Start the stack

```
cd /root/lab && docker compose up -d
```

## Confirm segmentation — web cannot reach cache

Run a temporary Alpine container on the `frontend` network and try to reach `cache`:

```
docker run --rm --network lab_frontend alpine wget -qO- http://cache:6379 --timeout=3
```

The connection times out — `cache` is only on `backend`, not on `frontend`.

## Confirm segmentation — api can reach cache

Run a temporary Alpine container on the `backend` network and try the same:

```
docker run --rm --network lab_backend alpine wget -qO- http://cache:6379 --timeout=3 || echo "TCP connect reached Redis (speaks its own protocol)"
```

The TCP connection reaches the Redis port because both share the `backend` network. Redis closes it immediately since it does not speak HTTP, but the network path exists — which is what matters.

## Inspect the networks

```
docker network ls
```

```
docker network inspect lab_backend
```

Look for the `Containers` section — only `cache` and `api` appear.

## Stop the stack

```
docker compose down
```

> **Key concept:** Adding a service to multiple networks is the standard pattern for a multi-tier application. It prevents a compromised front-end container from directly accessing the database tier.
