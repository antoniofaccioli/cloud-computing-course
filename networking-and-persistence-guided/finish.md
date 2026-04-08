# Exercise complete

**Cloud Computing and Distributed Systems**
Università degli Studi di Verona — A.A. 2025/2026

---

## What you have done

- Observed directly why container data is lost when a container is removed
- Created a named volume and verified that data survives container replacement
- Used a bind mount and accessed the same data from both the host and the container
- Created a user-defined bridge network and confirmed that containers resolve each other by name
- Demonstrated the difference between `EXPOSE` (declaration) and `-p` (host publishing)

---

## Key concepts to remember

**Named volumes** are managed by Docker. Their lifecycle is independent of any container — data persists until the volume is explicitly deleted.

**Bind mounts** map a host directory directly into the container. They are useful in development for live code reloading, but introduce host-path coupling that makes them unsuitable for production.

**User-defined bridge networks** provide automatic DNS resolution by container name. The default bridge network does not.

**`EXPOSE`** documents which port the application uses internally. **`-p`** creates the routing rule that makes the port accessible from the host.

---

## Commands used in this exercise

| Command | What it does |
|---|---|
| `docker volume create name` | Create a named volume |
| `docker volume ls` | List all volumes |
| `docker volume inspect name` | Show volume details and host path |
| `docker volume rm name` | Delete a volume |
| `docker run -v name:/path` | Mount a named volume |
| `docker run -v /host/path:/path` | Mount a bind mount |
| `docker network create name` | Create a user-defined network |
| `docker network ls` | List all networks |
| `docker network inspect name` | Show network details and attached containers |
| `docker run --network name` | Attach a container to a network |
| `docker run -p host:container` | Publish a port to the host |

---

Bring your answers to the debrief questions to the class discussion.
