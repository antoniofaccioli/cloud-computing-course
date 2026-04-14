# Step 3 — Add a reverse proxy and segment networks

## Objective

Add an **Nginx reverse proxy** as the sole public entry point and isolate the database on a private network.

## Network architecture to implement

```
Internet
    |
 proxy  (frontend network only)
    |
  api   (frontend + backend networks)
    |
   db   (backend network only)
```

External traffic enters through `proxy` on port **80**. The `proxy` forwards requests to `api`. The `db` is completely invisible from `proxy`.

## Constraints

**Networks**

Define two named bridge networks: `frontend` and `backend`.

- `proxy` joins only `frontend`
- `api` joins both `frontend` and `backend`
- `db` joins only `backend`

**proxy service**

- Use the image `nginx:alpine`
- Publish port **80** on the host, mapping to port **80** in the container
- Mount a bind mount that injects a custom Nginx configuration file into the container at `/etc/nginx/conf.d/default.conf`
- Remove the port mapping on `api` — it should no longer be directly reachable from the host

**Nginx configuration file**

Create a file called `nginx.conf` in `/root/app`. It must configure Nginx to proxy all requests to the `api` service. The minimal configuration block you need is a `server` block listening on port 80 with a `location /` that uses `proxy_pass` pointing to `http://api:80`.

**depends_on**

`proxy` must declare a dependency on `api` using `condition: service_started`.

## Verification

After bringing the stack up:

1. Confirm that a request to `http://localhost:80` returns a response (routed through `proxy` → `api`)
2. Confirm that `http://localhost:8080` no longer responds (direct access to `api` is gone)
3. Run a temporary Alpine container on the `frontend` network and verify it **cannot** reach `db` by name:

   ```
   docker run --rm --network app_frontend alpine nc -w 1 db 5432
   ```

   The command should fail with a hostname resolution error — `db` is not visible on `frontend`.

4. Run the same test from the `backend` network and verify it **can** reach `db`:

   ```
   docker run --rm --network app_backend alpine nc -w 1 db 5432
   ```

   The command should return immediately (PostgreSQL closes the connection after the greeting) — the network path exists.

## Final cleanup

Once all verifications pass, tear down the entire stack including volumes.
