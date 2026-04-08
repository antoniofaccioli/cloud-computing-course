# Exercise complete

**Cloud Computing and Distributed Systems**
Università degli Studi di Verona — A.A. 2025/2026

---

## What you have done

- Built and configured a persistent container using a named volume
- Connected two containers over a user-defined bridge network using name-based resolution
- Combined volume, network, and port mapping into a single correctly configured deployment
- Demonstrated the difference between the container port (used inside the network) and the host port (used to reach the service from outside Docker)

---

## The three rules to remember

**Persistence:** use named volumes for stateful containers in any environment beyond your local machine. The container is replaceable; the data is not.

**Networking:** always use user-defined bridge networks for multi-container applications. DNS resolution by name is only available there, not on the default bridge.

**Port mapping:** `EXPOSE` is documentation. `-p host_port:container_port` is the action. Only publish ports that need to be reachable from outside Docker — everything else stays internal.

---

Bring your answers to the debrief questions to the class discussion.
