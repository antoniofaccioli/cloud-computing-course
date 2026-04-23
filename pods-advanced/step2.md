# Objective 2 — Add a monitoring sidecar

Extend the manifest from Objective 1. Add a third container — a sidecar — to the same Pod.

Delete the existing Pod first, then update your manifest and reapply.

**Sidecar container** (`monitor`, image `busybox:1.36`):
- Runs continuously alongside `nginx` for the entire Pod lifetime
- Monitors the shared volume by running `ls -la` on the mounted directory every 5 seconds and printing the output
- Must mount the same `emptyDir` volume — choose a mount path different from the one used by `nginx`

**Verification you must complete:**

1. Apply the updated manifest. The Pod must reach `READY 2/2` — the init container does not count, only the two running containers (`nginx` and `monitor`) do.
2. Read the `monitor` sidecar logs with `kubectl logs` — you must see repeated output showing the file written by the init container.
3. Exec into the `monitor` container and verify you can read the same `index.html` file that `nginx` is serving.
4. Delete the Pod and observe: the `monitor` sidecar and `nginx` stop together. Recreate the Pod — the init container runs again, rewrites the file, then both containers start.

**Key question to answer for yourself:** the init container wrote the file before `nginx` and `monitor` started. When you delete and recreate the Pod, does the new init container see the file written by the previous one? Why or why not?
