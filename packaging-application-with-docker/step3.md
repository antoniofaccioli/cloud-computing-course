# Step 3 — Observe layer caching

## How the cache works

Every instruction in a Dockerfile produces a **layer**. Docker stores these layers locally. When you rebuild an image:

- If an instruction and its inputs have not changed → Docker reuses the cached layer (`CACHED`)
- If something has changed → Docker re-executes that instruction **and all instructions below it**

This means the order of instructions matters.

---

## Rebuild without changes

Rebuild `myapp:v1` without touching any file:

```
docker build -t myapp:v1 -f Dockerfile.v1 .
```

Every step shows `CACHED`. The build is almost instant.

---

## Simulate a code change

Modify one line of the application:

```
sed -i 's/running/running v2/' app.py
```

Rebuild:

```
docker build -t myapp:v1 -f Dockerfile.v1 .
```

Watch the output carefully.

---

> **Question before you continue:** which steps showed `CACHED` and which were re-executed? Why did `pip install` run again even though `requirements.txt` did not change?

Think about your answer — it connects directly to what you read in `Dockerfile.v1` in Step 1. Then click **NEXT**.
