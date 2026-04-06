# Step 2 — Build an image

## Build

Build an image from the Dockerfile in the current directory and tag it as `demo:v1`:

```
docker build -t demo:v1 .
```

Watch the output. Docker executes each instruction in the Dockerfile as a separate step and prints a number for each one. Every step produces a **layer**.

---

## Inspect the result

```
docker images
```

You will see `demo` with tag `v1` and its size. Note this number.

---

## Observe the layer cache

Run the build a second time without changing anything:

```
docker build -t demo:v1 .
```

This time every step shows **`CACHED`** in the output — Docker reused all existing layers because nothing changed. The build completes almost instantly.

Now modify the application file and rebuild:

```
echo '# updated' >> app.py
docker build -t demo:v1 .
```

Observe which steps are cached and which are re-executed. The step that copies `app.py` is no longer cached — and every step after it runs again from scratch.

---

When you are ready, click **NEXT**.
