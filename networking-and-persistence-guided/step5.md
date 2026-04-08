# Step 5 — Port exposure: EXPOSE vs -p

## What this step is about

There are two separate mechanisms that control port accessibility in Docker. The `EXPOSE` instruction in a Dockerfile is a declaration — it documents which port the application uses, but it does not make the port accessible from outside Docker. The `-p` flag in `docker run` is the action that actually creates the routing rule between the host and the container.

---

## Look at the Dockerfile

Read the Dockerfile of the application:

```
cat /root/app/Dockerfile
```

You will see the line `EXPOSE 5000`. This tells Docker — and anyone reading the file — that the application listens on port 5000. It does nothing else.

---

## Start a container WITHOUT the -p flag

```
docker run -d --name counter-nopub --network appnet counter:v1
```

Try to reach it from the host:

```
curl http://localhost:5000
```

This will fail — the port is not published to the host. The container is running and the application is listening on port 5000 inside the container, but there is no routing rule connecting the host's port 5000 to the container.

---

## Verify the container IS reachable from within the network

Even without `-p`, the container is still accessible to other containers on the same network:

```
docker run -it --rm --network appnet alpine sh
```

Inside the container:

```
wget -qO- http://counter-nopub:5000
```

This works — `EXPOSE` made the port available within the Docker network. The port was never published to the host, but intra-network communication works regardless of `-p`.

Exit:

```
exit
```

---

## Now publish the port to the host

Stop and remove the previous container:

```
docker stop counter-nopub
docker rm counter-nopub
```

Start a new container with `-p`:

```
docker run -d --name counter-pub --network appnet -p 8080:5000 -v counterdata:/data counter:v1
```

Note: the format is `host_port:container_port`. Here port **8080** on the host is mapped to port **5000** inside the container. The two numbers do not need to match.

Test it from the host:

```
curl http://localhost:8080
curl http://localhost:8080/increment
```

Now it works from the host as well.

---

## Clean up everything

```
docker stop counter-pub client counter
docker rm counter-pub client counter
docker network rm appnet
docker volume rm counterdata
```

---

> **Final question:** in your own words, what is the difference between `EXPOSE` and `-p`? In the application you built in this exercise, which port would you publish to the host and which would you leave internal — and why?

Keep your answers in mind for the class debrief. Click **NEXT** to see the summary.
