# Well done!

You have completed the progressive deploy exercise.

## What you built

Starting from two bare Dockerfiles, you assembled a complete two-service stack step by step — and each autonomous task was the necessary foundation for the next guided one.

**Step 1** — Built two Docker images, learning why instruction order matters for cache efficiency.

**Step 2** — Added named volumes to both services and verified that data survives container restarts.

**Step 3** — Created a user-defined bridge network and confirmed that containers reach each other by service name — something the default bridge cannot do.

**Step 4** — Translated the entire manually built infrastructure into a `docker-compose.yaml`, adopted existing resources with `external: true`, and added a healthcheck chain so the frontend only starts once the backend is ready.

## The pattern you practised

Every concept was introduced on one service with full guidance, then immediately applied to the second service autonomously. If you could not complete the autonomous part, the next guided step would not work — that is how you know you have genuinely understood it.
