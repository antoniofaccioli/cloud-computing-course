# Step 2 — Two-container application

## Objective

Run two containers on a user-defined bridge network so that one can reach the other **by container name**, without using IP addresses.

Specifically:
1. Create a user-defined bridge network
2. Start the counter application on that network — **do not publish any port to the host** at this stage
3. Start a second container (`alpine` or any lightweight image with `wget` or `curl`) on the same network
4. From inside the second container, reach the counter application using its container name as the hostname and increment the counter
5. Back on the host, inspect the network and identify the IP addresses assigned to both containers

---

## What to check

- Name-based resolution works inside the user-defined network: `wget -qO- http://<container_name>:5000` returns a valid response
- `docker network inspect <your_network>` shows both containers in the `Containers` section
- The counter application container has no published port visible in `docker ps` — it is unreachable from the host

---

> **Question:** what would happen if you tried the same name-based resolution on the default `bridge` network? Try it — start both containers without `--network` and attempt the same `wget` command. What error do you get?

Click **NEXT** when ready.
