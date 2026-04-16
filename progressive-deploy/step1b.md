# Step 1B — Build the backend image (your turn)

## Objective

Build an optimised Docker image for the backend service.

## What you need to do

1. Look at `/root/backend/Dockerfile` — it has the same inefficient instruction order as the frontend.
2. Edit the Dockerfile so that `requirements.txt` is copied and `pip install` is run **before** `COPY . .`. This way, the dependency layer is only rebuilt when `requirements.txt` changes.
3. Build the image and tag it `backend:v1`.
4. Run a container named `backend-v1` from that image, publishing port **5002** on the host (the app listens on port 5000 inside the container).
5. Wait a few seconds, then test that `http://localhost:5002/api` returns a JSON response.
6. Check `docker images` and compare the size of `backend:v1` with `frontend:v1`.
7. Stop and remove the `backend-v1` container when done (keep the image).

## Why this matters for the next step

Step 2A will start a new container from `backend:v1` with a named volume attached. If `backend:v1` does not exist, Step 2A will fail immediately.
