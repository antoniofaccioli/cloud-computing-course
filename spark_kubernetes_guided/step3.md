## Step 3 — Submit the Spark job

Get the API server IP:

```
export API_IP=$(kubectl get endpoints kubernetes -o jsonpath='{.subsets[0].addresses[0].ip}') && echo $API_IP
```{{exec}}

Extract the cluster CA certificate from the kubeconfig — Spark needs it to validate the TLS connection to the Kubernetes API:

```
kubectl config view --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 -d > /root/ca.crt
```{{exec}}

Submit the job. The kubeconfig and CA cert are mounted into the container so Spark can authenticate to the cluster:

```
docker run --rm --network host -v /root/.kube:/root/.kube -v /root/ca.crt:/root/ca.crt localhost:5000/spark-app:latest /opt/spark/bin/spark-submit --master k8s://https://$API_IP:6443 --deploy-mode cluster --name spark-k8s-job --conf spark.executor.instances=1 --conf spark.kubernetes.container.image=localhost:5000/spark-app:latest --conf spark.kubernetes.namespace=default --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa --conf spark.kubernetes.driver.pod.name=spark-driver --conf spark.kubernetes.driver.deletionGracePeriodSeconds=3600 --conf spark.kubernetes.authenticate.submission.caCertFile=/root/ca.crt --conf spark.kubernetes.authenticate.driver.caCertFile=/root/ca.crt local:///opt/spark/work-dir/job.py
```{{exec}}

While the job runs, open the tab **Terminal 2** and watch the Pods:

```
kubectl get pods --watch
```{{exec T2}}

You will see the Driver Pod appear (`Running`), then one Executor Pod. The Executor is deleted automatically when the job completes. The Driver Pod stays in `Completed` state. Press **Ctrl+C** in Terminal 2 to stop watching, then continue to the next step.
