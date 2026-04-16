# Step 3 — Optional services with profiles

## Concept

Not every service needs to run in every environment. A database administration UI is useful in development but should never be deployed to production. A Redis cache may be needed for performance testing but not during normal development.

Docker Compose **profiles** solve this problem. A service tagged with a profile is ignored by default and only started when that profile is explicitly activated with `--profile <name>`.

Services without any profile assignment always start. Services with a profile only start when that profile is active.

## What you need to build

Add two optional services to `docker-compose.yaml`:

**adminer** (profile: `tools`)
- Use the official `adminer` image
- Publish port **8081** on the host
- Connect it to `appnet`
- Assign it to the profile `tools`

**cache** (profile: `cache`)
- Use `redis:7-alpine`
- Mount a named volume for `/data`
- Connect it to `appnet`
- Add a healthcheck using `redis-cli ping`
- Assign it to the profile `cache`

Remember to declare the new named volume at the top level.

## Verification

All three scenarios below must work correctly.

**Scenario A — base services only (no profiles):**

Start the stack without activating any profile. Verify:

1. `docker compose ps` shows exactly two services: `api` and `db`
2. `adminer` and `cache` are **not** listed
3. `http://localhost:5000` responds (using `.env` defaults)

**Scenario B — with the tools profile:**

Bring the stack down, then start it with the `tools` profile active. Verify:

1. `docker compose ps` shows three services: `api`, `db`, and `adminer`
2. `http://localhost:8081` responds with the Adminer login page
3. `cache` is still **not** running

**Scenario C — with both profiles:**

Bring the stack down, then start it with both `tools` and `cache` profiles active simultaneously. Verify:

1. `docker compose ps` shows all four services: `api`, `db`, `adminer`, and `cache`
2. `http://localhost:8081` still responds
3. The cache service responds to a ping:

   ```
   docker compose exec cache redis-cli ping
   ```

   Expected response: `PONG`

## Final cleanup

Once all three scenarios pass, tear everything down including volumes:

```
docker compose --profile tools --profile cache down -v
```
