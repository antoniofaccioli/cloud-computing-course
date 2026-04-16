# Step 3A — Connect the frontend to a network (guided)

This step requires `frontend-v2` to be running (from Step 2B). If the container is not running, go back and complete Step 2B first.

## Create a user-defined bridge network

```
docker network create appnet
```

## Connect the running frontend container to the network

Docker lets you connect a running container to a network without restarting it:

```
docker network connect appnet frontend-v2
```

## Verify the connection

```
docker network inspect appnet
```

Look at the `Containers` section — `frontend-v2` should appear with its IP address on `appnet`.

## Test DNS resolution by container name

On the default bridge network, containers cannot reach each other by name. On a user-defined network, Docker registers each container's name as a DNS hostname automatically.

Run a temporary Alpine container on `appnet` and try to reach the frontend by name:

```
docker run --rm --network appnet alpine wget -qO- http://frontend-v2:5000
```

You get the HTML response — reached by name, not by IP address.

Now try the same from outside `appnet`:

```
docker run --rm alpine wget -qO- --timeout=3 http://frontend-v2:5000
```

This fails — the Alpine container is not on `appnet` and cannot resolve the name.

> **Key concept:** DNS resolution by container name only works on user-defined bridge networks. The default bridge requires IP addresses.
