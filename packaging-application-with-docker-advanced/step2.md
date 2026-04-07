# Step 2 — Layer caching

## Objective

Demonstrate the caching problem in `Dockerfile.v1` and show how `Dockerfile.v2` fixes it.

Specifically:
1. Rebuild `myapp:v1` after modifying `app.py` — observe which layers are re-executed
2. Build `myapp:v2` from `Dockerfile.v2`, apply the same change to `app.py`, rebuild — observe the difference

---

## What to check

- After modifying `app.py` and rebuilding with `Dockerfile.v1`: `pip install` runs again
- After modifying `app.py` and rebuilding with `Dockerfile.v2`: `pip install` shows `CACHED`

---

> Before moving on: in one sentence, explain why the two Dockerfiles behave differently when the application code changes. You will be asked this during the debrief.

Click **NEXT** when ready.
