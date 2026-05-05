# Step 1 — Build the image and import into containerd

Build the telemetry API image from `/root/telemetry-api/`, import it into containerd, and verify Kubernetes can see it.

---

**Commands available for this step:**

- `docker build`
- `docker save`
- `ctr -n k8s.io images import`
- `crictl images`
