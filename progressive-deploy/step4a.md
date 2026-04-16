# Step 4A — Write the docker-compose.yaml (guided)

You have built both images, created the volumes and the network manually. Now you will describe the same infrastructure declaratively in a single `docker-compose.yaml` file and let Compose manage everything.

## Stop the manually started containers

```
docker stop frontend-v2 backend-v2
```

```
docker rm frontend-v2 backend-v2
```

The volumes `frontdata` and `backdata` are preserved — named volumes are never removed by `docker stop` or `docker rm`.

## Verify the network before writing the Compose file

Both containers should be connected to `appnet` — this is what you set up in Step 3B. Check it now:

```
docker network inspect appnet --format '{{range .Containers}}{{.Name}} {{end}}'
```

You should see both `frontend-v2` and `backend-v2` listed. If `backend-v2` is missing, go back and complete Step 3B first.

## Create the project directory

```
mkdir -p /root/app
```

## Write the Compose file

```
cat > /root/app/docker-compose.yaml << 'EOF'
services:
  frontend:
    image: frontend:v1
    ports:
      - "5001:5000"
    volumes:
      - frontdata:/app/data
    networks:
      - appnet

  backend:
    image: backend:v1
    ports:
      - "5002:5000"
    volumes:
      - backdata:/app/data
    networks:
      - appnet

volumes:
  frontdata:
    external: true
  backdata:
    external: true

networks:
  appnet:
    external: true
EOF
```

The `external: true` flag tells Compose to use the existing `frontdata`, `backdata`, and `appnet` resources instead of creating new ones. Your data is preserved.

## Start the stack

```
cd /root/app && docker compose up -d
```

## Verify

```
docker compose ps
```

```
curl http://localhost:5001
```

```
curl http://localhost:5002/api
```

Both services respond. The visit counter and the message list continue from where you left them — the same volumes are in use.

## Test inter-service DNS

```
docker run --rm --network appnet alpine wget -qO- http://backend:5000/api
```

The backend is reachable from within `appnet` using its Compose service name `backend`.

> **Key concept:** `external: true` tells Compose to adopt existing infrastructure rather than create it. This is useful during migration — you can gradually move manually managed resources under Compose control.
