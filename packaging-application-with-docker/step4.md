# Step 4 — Fix the Dockerfile and verify the cache

## Read the corrected Dockerfile

```
cat Dockerfile.v2
```

Compare it with `Dockerfile.v1`. The key difference: `COPY requirements.txt .` and `RUN pip install` now come **before** `COPY . .`. This way, the dependency layer is only re-executed when `requirements.txt` changes — not when the application code changes.

---

## Restore the application file

Before rebuilding, restore `app.py` to its original state:

```
sed -i 's/running v2/running/' app.py
```

## Build with the corrected Dockerfile

```
docker build -t myapp:v2 -f Dockerfile.v2 .
```

---

## Simulate the same code change

```
sed -i 's/running/running v2/' app.py
```

Rebuild:

```
docker build -t myapp:v2 -f Dockerfile.v2 .
```

---

> **Question before you continue:** this time, which steps showed `CACHED`? Compare the output with what you saw in Step 3. What changed and why?

Restore `app.py` before moving on:

```
sed -i 's/running v2/running/' app.py
```

Click **NEXT**.
