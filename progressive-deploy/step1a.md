# Step 1A — Build the frontend image (guided)

## Look at the Dockerfile

```
cat /root/frontend/Dockerfile
```

Notice the order of instructions: `COPY . .` comes **before** `pip install`. This means that any change to any file — even a one-line edit in `app.py` — will invalidate the pip layer and force a full reinstall of all dependencies. This is inefficient.

## Build the image as-is

```
docker build -t frontend:v1 /root/frontend
```

## Run the container

```
docker run -d -p 5001:5000 --name frontend-v1 frontend:v1
```

```
sleep 3
```

## Test it

```
curl http://localhost:5001
```

You should see an HTML page with a visit count.

## Check the image size

```
docker images frontend:v1
```

Note the size. You will compare it with the optimised version in Step 1B.

## Stop the container (keep the image)

```
docker stop frontend-v1 && docker rm frontend-v1
```

> **Key concept:** The order of Dockerfile instructions determines cache efficiency. Instructions that change rarely — like installing dependencies — should come before instructions that change often, like copying source code.
