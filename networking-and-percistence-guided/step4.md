# Step 4 — Container networking

## What this step is about

By default, containers on the same host cannot reach each other by name — they would need to use internal IP addresses, which change every time a container restarts. User-defined bridge networks solve this problem: Docker runs an embedded DNS server that maps each container's name to its current IP automatically.

In this step you will create two containers on a shared network and verify that they can find each other by name.

---

## Create a user-defined bridge network

```
docker network create appnet
```

List available networks to confirm it was created:

```
docker network ls
```

You will see `appnet` listed alongside the default `bridge`, `host`, and `none` networks.

---

## Start the counter application on the network

Use the named volume from Step 2 so the data is still there:

```
docker run -d --name counter --network appnet -v counterdata:/data counter:v1
```

Notice there is no `-p` flag this time — the container is not published to the host. It is only accessible from within the `appnet` network.

---

## Start a second container on the same network

This container will act as a client. It will try to reach the counter application using its container name as the hostname:

```
docker run -it --name client --network appnet alpine sh
```

You are now inside the `client` container. Run the following commands:

```
wget -qO- http://counter:5000
```

The `counter` name resolves automatically to the IP address of the counter container — you did not need to know or specify any IP address.

Try the increment endpoint as well:

```
wget -qO- http://counter:5000/increment
wget -qO- http://counter:5000/increment
```

Exit the client container:

```
exit
```

---

## Inspect the network

Back on the host, inspect the network to see which containers are attached and what IP addresses they received:

```
docker network inspect appnet
```

Look at the `Containers` section — you will see both `counter` and `client` listed with their assigned IP addresses.

---

## What happens on the default bridge?

To understand why user-defined networks are needed, try the same test on the default bridge:

```
docker run -d --name counter-default counter:v1
docker run -it --name client-default alpine sh
```

Inside the `client-default` container:

```
wget -qO- http://counter-default:5000
```

This will fail with a name resolution error — the default bridge does not provide DNS resolution by container name. Exit the container:

```
exit
```

Clean up the default bridge containers:

```
docker stop counter-default client-default
docker rm counter-default client-default
```

Also stop the `client` container still running on `appnet`:

```
docker stop client
docker rm client
```

---

> **Question:** on which network did name-based resolution work, and on which did it fail? What is the practical consequence of this difference when building a multi-container application?

Click **NEXT** to continue.
