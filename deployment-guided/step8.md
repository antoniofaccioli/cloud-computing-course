# Step 8 — Verify internal connectivity

A ClusterIP Service is only reachable from within the cluster. We will launch a temporary
debug Pod to verify that the Service correctly routes traffic using its DNS name.

Run a temporary Pod with curl available:

```
kubectl run debug --image=curlimages/curl --rm -it --restart=Never -- sh
```{{exec}}

Once inside the debug Pod shell, test connectivity using the Service name:

```
curl -s http://web-svc | head -5
```{{exec}}

You should see the beginning of the nginx HTML response. CoreDNS resolved `web-svc` to the
ClusterIP of the Service, and the Service forwarded the request to one of the Pods.

Test a few more times to observe load balancing across the Pod replicas:

```
curl -s http://web-svc -o /dev/null -w "%{http_code}\n"
curl -s http://web-svc -o /dev/null -w "%{http_code}\n"
curl -s http://web-svc -o /dev/null -w "%{http_code}\n"
```{{exec}}

All three requests should return `200`.

Exit the debug Pod:

```
exit
```{{exec}}

The debug Pod is automatically deleted because of the `--rm` flag.

> **What just happened?**
> Inside the cluster, `web-svc` resolves to the ClusterIP via CoreDNS.
> kube-proxy on the node intercepts traffic to the ClusterIP and forwards it to one of the
> healthy Pod IPs listed in the Endpoints object. No Pod IP was hardcoded anywhere.
