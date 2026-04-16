# Step 2A — Add persistence to the backend (guided)

This step uses `backend:v1` — the image you built in Step 1B. If that image does not exist yet, go back and complete Step 1B first.

## The problem: data disappears on restart

Run the backend without a volume and observe what happens to its data.

```
docker run -d -p 5002:5000 --name backend-v1 backend:v1
```

```
sleep 3
```

Make a few requests to accumulate data:

```
curl http://localhost:5002/api
```

```
curl http://localhost:5002/api
```

Now destroy and recreate the container:

```
docker stop backend-v1 && docker rm backend-v1
```

```
docker run -d -p 5002:5000 --name backend-v1 backend:v1
```

```
sleep 3
```

```
curl http://localhost:5002/api
```

The message list resets to `["Request #1"]`. All previous data is gone — the container's writable layer was destroyed with it.

## The solution: a named volume

Stop and remove the container again:

```
docker stop backend-v1 && docker rm backend-v1
```

Create a named volume:

```
docker volume create backdata
```

Start the backend with the volume mounted at `/app/data`:

```
docker run -d -p 5002:5000 -v backdata:/app/data --name backend-v2 backend:v1
```

```
sleep 3
```

Make a few requests:

```
curl http://localhost:5002/api
```

```
curl http://localhost:5002/api
```

Now destroy and recreate the container — the volume stays:

```
docker stop backend-v2 && docker rm backend-v2
```

```
docker run -d -p 5002:5000 -v backdata:/app/data --name backend-v2 backend:v1
```

```
sleep 3
```

```
curl http://localhost:5002/api
```

The messages are still there. The named volume `backdata` survived the container lifecycle.

> **Key concept:** `docker stop` and `docker rm` remove the container. They do **not** remove named volumes. Use `docker volume rm backdata` only when you explicitly want to delete the data.
