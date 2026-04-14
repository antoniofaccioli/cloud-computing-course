# Step 2 — Add a database with persistence

## Objective

Verify that the named volume keeps PostgreSQL data alive across container restarts, then add a **healthcheck** to `db` and make `api` wait for it before starting.

## Part A — Verify persistence

While the stack is running, write a value into the database, destroy the `db` container, recreate it, and confirm the value is still there.

**Steps to follow:**

1. Open an interactive `psql` session inside the running `db` container. The database name, user, and password are the ones you set in Step 1.
2. Create a table and insert one row, then exit the session.
3. Bring the stack down **without** removing volumes.
4. Bring the stack back up and reconnect to `psql`.
5. Confirm the table and row are still present.

> The distinction between `docker compose down` and `docker compose down -v` is critical here. Make sure you use the right one.

## Part B — Add a healthcheck and startup dependency

Modify the `docker-compose.yaml` to ensure that:

- `db` has a healthcheck that periodically runs `pg_isready` to verify PostgreSQL is accepting connections. Use the `-U` flag to pass the database user.
- `api` declares a `depends_on` entry for `db` using `condition: service_healthy` — it must not start until the database healthcheck passes.

After updating the file, bring the stack down and back up. Then verify:

1. `docker compose ps` shows `db` with a health status of `healthy`
2. The `api` container started after `db` became healthy (check the timestamps with `docker compose logs --timestamps db api`)
