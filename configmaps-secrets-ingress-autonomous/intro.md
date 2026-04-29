# Lesson 15 — Exercise B: autonomous extension

The cluster from Exercise A is already running:

- Namespace `lesson15` with `frontend` and `api` Deployments and Services
- A ConfigMap `app-config` and a Secret `db-secret`
- The Nginx Ingress Controller installed and ready
- An Ingress `app-ingress` with path-based routing for `myapp.local`

**Your objectives in this exercise:**

1. Deploy a third service (`dashboard`) with its own dedicated ConfigMap
2. Prove that a volume-mounted ConfigMap updates live without restarting the Pod
3. Extend the existing Ingress with a new host-based rule for `dashboard.local`

No step-by-step commands are given. Use the **Command reference** (Step 4) if you need a hint on syntax. Write your own YAML manifests.

Good luck.
