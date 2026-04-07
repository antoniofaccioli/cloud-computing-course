# Step 3 — Multi-stage build

## Objective

Build `myapp:v3` from `Dockerfile.v3`. Verify the application still works correctly. Compare the image size against `myapp:v1`.

---

## What to check

- `curl http://localhost:5000` returns the same JSON response as before
- `docker images` shows a measurable size difference between `myapp:v1` and `myapp:v3`

---

## Going further

If you have time, open `Dockerfile.v3` and answer these questions for yourself:

- What does the `AS builder` label on the first `FROM` instruction do?
- What does `COPY --from=builder` do?
- If you added a second Python dependency to `requirements.txt`, which stage would be affected and which would not?

> Bring your answers to the class debrief.

Click **NEXT** to see the summary.
