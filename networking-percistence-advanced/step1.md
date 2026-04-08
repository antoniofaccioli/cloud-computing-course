# Step 1 — Persistent counter

## Objective

Build the image from `/root/app` and run the counter application so that its visit count **survives container replacement**.

Specifically:
1. Build the image and tag it `counter:v1`
2. Run the container with a named volume so that `/data` inside the container is persisted
3. Increment the counter at least five times via `curl http://localhost:5000/increment`
4. Stop and completely remove the container
5. Start a new container using the same named volume
6. Verify that the count picks up where it left off

---

## What to check

- `docker volume ls` shows your volume
- After restarting the container, `curl http://localhost:5000` returns the correct accumulated count
- `docker volume inspect <your_volume>` shows the host path where the data lives — open that path and confirm the JSON file is there

---

> **Question:** what command would you use to delete the volume along with the container in a single operation? What is the risk of doing so, and when is it safe?

Click **NEXT** when ready.
