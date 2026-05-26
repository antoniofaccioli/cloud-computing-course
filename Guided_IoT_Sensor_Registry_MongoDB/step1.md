# Step 1 — Starting the MongoDB container

Launch a MongoDB 7 container:

```bash
docker run -d --name mongo -p 27017:27017 mongo:7
```{{exec}}

Wait for the server to initialise:

```bash
sleep 8
```{{exec}}

Verify MongoDB is accepting connections:

```bash
docker exec mongo mongosh --eval "db.adminCommand('ping')"
```{{exec}}

You should see `{ ok: 1 }`. The server is ready.
