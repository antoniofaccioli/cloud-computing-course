# Step 3 — Controlled exposure

## Objective

Combine everything from the previous steps into a correctly configured deployment: persistent storage, network isolation, and selective port publishing.

Specifically:
1. Ensure a named volume exists for the counter data
2. Run the counter application with:
   - the named volume mounted at `/data`
   - attached to your user-defined network
   - **port 5000 of the container published to port 8080 of the host**
3. Verify that:
   - `curl http://localhost:8080` reaches the application from the host
   - the accumulated count from previous steps is still present (the volume was not deleted)
   - another container on the same network can still reach the application by name on port 5000 (intra-network access uses the container port, not the host port)

---

## What to check

- `docker ps` shows port mapping `0.0.0.0:8080->5000/tcp`
- `curl http://localhost:8080/increment` works from the host
- From a second container on the same network, `wget -qO- http://<counter_name>:5000` also works
- `docker volume inspect` confirms data is stored in the named volume

---

## Final cleanup

When you are satisfied, clean up all resources:

```
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker network prune -f
docker volume prune -f
```

---

> **Final question:** you published port 8080 on the host but used port 5000 inside the network. Explain in one sentence why these two numbers can differ and what each one refers to. When would you choose to make them the same?

Bring your answers to the class debrief. Click **NEXT** to see the summary.
