# Step 5 — Multi-stage build

## The problem with single-stage images

When Docker installs Flask, it also keeps `pip`, build tools, and temporary cache files inside the image. These are needed during the build — but the running container never uses them. They just take up space.

A **multi-stage build** solves this by using two separate stages:
- **Stage 1 (`builder`)**: installs all dependencies
- **Stage 2 (`runtime`)**: starts from a clean base and copies only what is needed to run the application

The final image contains only the runtime stage. Everything from the builder stage is discarded.

---

## Read the multi-stage Dockerfile

```
cat Dockerfile.v3
```

Notice the two `FROM` instructions — one for each stage. The `COPY --from=builder` instruction is how the runtime stage takes the installed packages from the builder stage.

---

## Build the multi-stage image

```
docker build -t myapp:v3 -f Dockerfile.v3 .
```

---

## Compare image sizes

```
docker images
```

Look at the `SIZE` column for `myapp:v1`, `myapp:v2`, and `myapp:v3`.

---

## Verify the application still works

```
docker run -d -p 5000:5000 --name myapp-v3 myapp:v3
curl http://localhost:5000
docker stop myapp-v3 && docker rm myapp-v3
```

---

> **Final question:** how many MB did you save with the multi-stage build compared to `myapp:v1`? What do you think was removed from the final image?

Keep your answer in mind for the class debrief. Click **NEXT** to see the summary.
