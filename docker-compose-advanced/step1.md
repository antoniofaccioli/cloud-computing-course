# Step 1 — Bootstrap the project

## Objective

Create a `docker-compose.yaml` in `/root/app` that defines two services: **api** and **db**.

## Constraints

**api**
- Use the image `traefik/whoami`
- Expose it on host port **8080**, mapping to the container's port **80**

**db**
- Use the image `postgres:16-alpine`
- Pass the following environment variables to configure the database:
  - `POSTGRES_USER` set to `appuser`
  - `POSTGRES_PASSWORD` set to `secret`
  - `POSTGRES_DB` set to `appdb`
- Mount a **named volume** called `pgdata` to the path `/var/lib/postgresql/data` inside the container — this is where PostgreSQL stores its data files

Remember to declare the named volume at the top-level `volumes` section.

## Verification

Once you have written the file, bring the stack up in detached mode and confirm that:

1. Both services appear as running
2. A request to `http://localhost:8080` returns a response from the `api` container
3. The named volume `app_pgdata` exists (Compose prefixes volumes with the project name)

## Hint

The project name is derived from the working directory. Running `docker compose up` from `/root/app` gives the project the name `app`.
