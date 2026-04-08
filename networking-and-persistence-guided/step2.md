# Step 2 — Named volumes

## What this step is about

A named volume is a storage directory created and managed by Docker. Its lifecycle is completely independent from any container — data written to a volume survives even when the container is stopped and removed.

---

## Stop and remove the current container

```
docker stop counter2
docker rm counter2
```

---

## Create a named volume

```
docker volume create counterdata
```

List existing volumes to confirm it was created:

```
docker volume ls
```

You will see `counterdata` listed with driver `local`.

---

## Run the container with the volume mounted

The `-v` flag mounts the volume into the container. The format is `volume_name:path_inside_container`. The application writes its data to `/data`, so that is where the volume must be mounted:

```
docker run -d -p 5000:5000 --name counter3 -v counterdata:/data counter:v1
```

Increment the counter several times:

```
curl http://localhost:5000/increment
curl http://localhost:5000/increment
curl http://localhost:5000/increment
curl http://localhost:5000/increment
curl http://localhost:5000/increment
```

Check the count (should be **5**):

```
curl http://localhost:5000
```

---

## Destroy the container — the volume survives

```
docker stop counter3
docker rm counter3
```

Verify that the volume still exists:

```
docker volume ls
```

---

## Recreate the container with the same volume

```
docker run -d -p 5000:5000 --name counter4 -v counterdata:/data counter:v1
curl http://localhost:5000
```

---

## Inspect the volume

Find out exactly where Docker stores the volume data on the host:

```
docker volume inspect counterdata
```

Look at the `Mountpoint` field — that is the actual directory on the host filesystem where the data lives.

---

> **Question:** what value does `visits` show after restarting with the same volume? What does this tell you about the relationship between a container and its data?

Click **NEXT** to continue.
