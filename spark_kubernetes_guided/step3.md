## Step 3 — Submit the Spark job

Open a second terminal and start watching Pod creation — do this **before** submitting the job:

```
watch kubectl get pods
```{{exec T2}}

Back in the first terminal, get the Kubernetes API server IP:

```
export API_IP=$(kubectl get endpoints kubernetes -o jsonpath='{.subsets[0].addresses[0].ip}') && echo $API_IP
```{{exec}}

Submit the job. The `--conf spark.kubernetes.driver.deletionGracePeriodSeconds=3600` flag keeps the Driver Pod in `Completed` state after the job finishes, so you can inspect its logs in the next step:

```
docker run --rm --network host -v /root/.kube:/root/.kube localhost:5000/spark-app:latest /opt/spark/bin/spark-submit --master k8s://https://$API_IP:6443 --deploy-mode cluster --name spark-k8s-job --conf spark.executor.instances=1 --conf spark.kubernetes.container.image=localhost:5000/spark-app:latest --conf spark.kubernetes.namespace=default --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa --conf spark.kubernetes.driver.pod.name=spark-driver --conf spark.kubernetes.driver.deletionGracePeriodSeconds=3600 local:///opt/spark/work-dir/job.py
```{{exec}}

Watch the second terminal: the Driver Pod appears first (`Running`), then one Executor Pod. The Executor Pod is deleted automatically when the job completes. The Driver Pod stays in `Completed` state.

When you see the Driver Pod in `Completed` state, press **Ctrl+C** in the second terminal to stop `watch`, then continue to the next step.
