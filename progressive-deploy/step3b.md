# Step 3B — Connect the backend to the same network (your turn)

## Objective

Add the backend to `appnet` so that the two services can communicate by name.

## What you need to do

1. Connect the running `backend-v2` container to `appnet`.
2. Verify that `backend-v2` appears in `docker network inspect appnet`.
3. Run a temporary Alpine container on `appnet` and confirm it can reach `backend-v2` by name at `http://backend-v2:5000/api`.
4. From the same temporary Alpine container, confirm it can also reach `frontend-v2` by name at `http://frontend-v2:5000`.

Both services are now on the same network and reachable by name from any container on `appnet`.

Leave both `frontend-v2` and `backend-v2` **running** when you are done.

## Why this matters for the next step

Step 4A will write a `docker-compose.yaml` that recreates this exact setup — two services, two volumes, one network. It will stop both containers first and bring them back up through Compose. If either container is missing or the network does not exist, the Compose verification will not match what is expected.
