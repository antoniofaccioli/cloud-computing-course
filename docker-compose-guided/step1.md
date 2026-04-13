# Step 1 — Your first Compose file

A `docker-compose.yaml` file describes the desired state of your application. Compose reads it and creates all the necessary containers, networks, and volumes.

## Create the project directory

```
mkdir -p /root/lab && cd /root/lab
```

## Write the Compose file

Create the file with the following content:

```
cat > /root/lab/docker-compose.yaml << 'EOF'
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
EOF
```

This defines a single service called `web` using the official `nginx:alpine` image. The `ports` directive maps port **8080 on the host** to port **80 inside the container**.

## Start the stack

```
cd /root/lab && docker compose up -d
```

The `-d` flag runs the stack in detached mode (in the background).

## Verify the service is running

```
docker compose ps
```

You should see the `web` service listed with status **running**.

## Test the web server

```
curl http://localhost:8080
```

You should see the default Nginx welcome page HTML.

## Inspect the logs

```
docker compose logs web
```

## Stop the stack

```
docker compose down
```

`docker compose down` stops and removes the containers and the default network. The image is kept locally.

> **Key concept:** The service name (`web`) becomes the container's DNS hostname within the Compose network. Other services can reach it using `http://web`.
