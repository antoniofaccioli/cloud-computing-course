# Step 1 — Build and run

## Objective

From the `/root/app` directory, build a Docker image from `Dockerfile.v1` and tag it `myapp:v1`. Run a container from it on port 5000 and verify the application responds correctly.

When you are satisfied the application is running, stop and remove the container.

---

## What to check

- `docker images` shows `myapp:v1` with its size
- `curl http://localhost:5000` returns a JSON response
- `docker ps -a` shows no running or stopped containers when you are done

---

> Before moving on: look at the size of `myapp:v1`. Keep that number in mind.

Click **NEXT** when ready.
