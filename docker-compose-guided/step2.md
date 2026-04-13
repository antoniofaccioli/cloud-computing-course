# Step 2 — Adding a second service

A real application is rarely a single container. In this step you add a second service alongside Nginx: a lightweight HTTP responder called **whoami** that returns information about the host it is running on.

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
EOF
```

## Start the updated stack

```
cd /root/lab && docker compose up -d
```

Compose is smart: it only creates the new `api` container. The existing `web` container is not recreated because its definition has not changed.

## Check both services

```
docker compose ps
```

## Test both services

```
curl http://localhost:8080
```

```
curl http://localhost:8081
```

The second command returns plain-text information about the container (hostname, IP address, request headers).

## Observe inter-service DNS

Compose automatically creates a shared network and registers each service under its name as a DNS hostname. Run a temporary Alpine container on the same network to verify:

```
docker run --rm --network lab_default alpine wget -qO- http://api
```

Alpine has `wget` built in. The `api` service responds — reached by name, not by IP address. The network name `lab_default` is created automatically by Compose, prefixed with the project name (`lab`, taken from the working directory name).

## Stop the stack

```
docker compose down
```

> **Key concept:** `docker compose up -d` is **idempotent** — running it again on an unchanged file does nothing. Compose only acts on differences between the desired state (the YAML) and the current state (running containers).
