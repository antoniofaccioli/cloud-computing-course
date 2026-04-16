# Step 2B — Add persistence to the frontend (your turn)

## Objective

Apply the same persistence pattern to the frontend service.

## What you need to do

1. Create a named volume called `frontdata`.
2. Start a container named `frontend-v2` from `frontend:v1`, publishing port **5001** on the host, with `frontdata` mounted at `/app/data`.
3. Make several requests to `http://localhost:5001` and observe the visit counter incrementing.
4. Destroy the container and recreate it with the same volume.
5. Verify that the visit counter continues from where it left off — it does not reset to 1.

Leave `frontend-v2` **running** when you are done. Do not stop it.

## Why this matters for the next step

Step 3A will connect `frontend-v2` to a user-defined network. If the container does not exist and is not running, Step 3A will fail.
