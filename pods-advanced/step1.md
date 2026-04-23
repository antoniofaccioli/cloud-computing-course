# Objective 1 — Init container + main container

Write a manifest for a Pod named `init-nginx-pod` with the following structure:

**Init container** (`prepare`, image `busybox:1.36`):
- Writes a custom HTML page to an `emptyDir` volume
- The page must contain your name or any text of your choice
- Must terminate successfully before the main container starts

**Main container** (`nginx`, image `nginx:1.25`):
- Mounts the same `emptyDir` volume at `/usr/share/nginx/html`
- Serves the file written by the init container

**Verification you must complete before moving to Objective 2:**

1. Apply the manifest and observe the Pod status transition — it must pass through `Init:0/1` before reaching `Running`. Use `kubectl get pod init-nginx-pod -w` to watch it live.
2. Once `Running`, exec into the `nginx` container and read the file at `/usr/share/nginx/html/index.html` — it must contain the text written by the init container.
3. Check that no init container appears in `kubectl get pod init-nginx-pod` under `READY` — init containers do not count in the ready count. Confirm with `kubectl describe pod init-nginx-pod` that the init container shows `State: Terminated` and `Exit Code: 0`.

**If something goes wrong:** check init container logs with `kubectl logs init-nginx-pod -c prepare`. A non-zero exit code means the init container failed — inspect the error and fix the manifest.
