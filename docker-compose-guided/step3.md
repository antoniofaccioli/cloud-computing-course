# Step 3 — Persistent storage with volumes

Containers are ephemeral: when a container is removed, all data written inside it is lost. A **named volume** keeps data alive independently of any container lifecycle.

In this step you add a **Redis** data store and give it a named volume so that cached data survives restarts.

## Update the Compose file

```
cat > /root/lab/docker-compose.yaml << 'EOF'
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"

  api:
    image: traefik/whoami
    ports:
      - "8081:80"

  cache:
    image: redis:7-alpine
    volumes:
      - redisdata:/data

volumes:
  redisdata:
EOF
```

The `volumes` key at the top level declares the named volume `redisdata`. Docker manages its location on the host. The `cache` service mounts it at `/data`, which is where Redis stores its persistence files.

## Start the stack

```
cd /root/lab && docker compose up -d
```

## Write data to Redis

```
docker compose exec cache redis-cli SET greeting "hello from compose"
```

## Read the data back

```
docker compose exec cache redis-cli GET greeting
```

You should see `"hello from compose"`.

## Destroy and recreate the container

```
docker compose down
```

```
docker compose up -d
```

## Verify the data survived

```
docker compose exec cache redis-cli GET greeting
```

The value is still there because the volume `redisdata` was not removed by `docker compose down`. Data is tied to the volume, not to the container.

## Inspect the volume

```
docker volume inspect lab_redisdata
```

Note that Compose prefixes the volume name with the project name (`lab`, taken from the directory name).

## Stop the stack

```
docker compose down
```

> **Key concept:** `docker compose down` preserves named volumes by default. Use `docker compose down -v` only when you explicitly want to delete the volume data.
