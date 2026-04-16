# Step 2 — Environment variable interpolation

## Concept

Hardcoding values like passwords and port numbers directly in `docker-compose.yaml` is a bad practice: it makes rotating credentials difficult and risks exposing secrets in version control.

Docker Compose supports **variable interpolation**: any value in the YAML can reference an environment variable using the `${VARIABLE_NAME}` syntax. Compose reads these variables from the shell environment or from a `.env` file in the project directory.

## What you need to build

### The `.env` file (development defaults)

Create `/root/app/.env` with the following variables:

```
APP_ENV=development
DB_USER=appuser
DB_PASSWORD=devpassword
DB_NAME=appdb
API_PORT=5000
```

### Update `docker-compose.yaml` to use interpolation

Modify the base `docker-compose.yaml` so that **every hardcoded value** is replaced with a variable reference:

- The PostgreSQL environment variables (`POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`) must reference `${DB_USER}`, `${DB_PASSWORD}`, and `${DB_NAME}`
- The `APP_ENV` on the api service must reference `${APP_ENV}`
- The `API_PORT` environment variable on the api service must reference `${API_PORT}`

Also update `docker-compose.override.yaml` so that the published port uses `${API_PORT}:${API_PORT}` instead of a hardcoded value.

### The `.env.production` file

Create `/root/app/.env.production` with different values:

```
APP_ENV=production
DB_USER=produser
DB_PASSWORD=strongpassword123
DB_NAME=proddb
API_PORT=8080
```

## Verification

**With the default `.env` (development):**

Bring the stack up normally. Then verify:

1. `docker compose exec api env` shows `APP_ENV=development` and `DB_USER=appuser`
2. A request to `http://localhost:5000` returns JSON where `"env"` is `"development"` and `"db_user"` is `"appuser"`

**With `.env.production`:**

Bring the stack down, then start it again passing the production env file explicitly (there is a flag for this). Then verify:

1. `docker compose exec api env` shows `APP_ENV=production` and `DB_USER=produser`
2. A request to `http://localhost:8080` returns JSON where `"env"` is `"production"` and `"db_user"` is `"produser"`
3. `http://localhost:5000` is **not** reachable (the port has changed to 8080)

Bring the stack down before moving to Step 3.

## Why this matters for the next step

Step 3 adds new services to `docker-compose.yaml`. If the file does not use interpolation as required, the profile-based services in Step 3 will be added on top of a misconfigured base and the final verification will not match expectations.
