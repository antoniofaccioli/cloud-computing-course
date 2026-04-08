# Step 3 — Bind mounts

## What this step is about

A bind mount maps a specific directory from the host machine directly into the container. Unlike a named volume, the location on the host is chosen explicitly by you. This makes bind mounts useful in development — you can edit files on the host and see the changes immediately inside the container.

---

## Stop and remove the current container

```
docker stop counter4
docker rm counter4
```

---

## Create a directory on the host

```
mkdir -p /root/mydata
```

---

## Run the container with a bind mount

The syntax is identical to a named volume but uses a full host path instead of a volume name:

```
docker run -d -p 5000:5000 --name counter5 -v /root/mydata:/data counter:v1
```

Increment the counter a few times:

```
curl http://localhost:5000/increment
curl http://localhost:5000/increment
curl http://localhost:5000/increment
```

---

## Inspect the data on the host directly

Because a bind mount is just a host directory mounted into the container, you can read and write the data from the host as well:

```
cat /root/mydata/counter.json
```

You will see the JSON file that the application wrote — sitting directly on the host filesystem, accessible from outside Docker.

---

## Verify that changes on the host are immediately visible inside the container

Overwrite the counter value from the host side:

```
echo '{"count": 100}' > /root/mydata/counter.json
```

Now check the application:

```
curl http://localhost:5000
```

---

## Stop and remove the container — does the data survive?

```
docker stop counter5
docker rm counter5
ls /root/mydata/
```

---

> **Question:** the data in `/root/mydata` still exists after removing the container. How is this different from the behaviour you observed in Step 1, and why? When would you prefer a bind mount over a named volume?

Click **NEXT** to continue.
