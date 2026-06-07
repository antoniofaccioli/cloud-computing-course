## Step 3 — Submit the Spark job

Verify that `spark-submit` is available on the host:

```
spark-submit --version
```{{exec}}

Get the API server IP:

```
export API_IP=$(kubectl get endpoints kubernetes -o jsonpath='{.subsets[0].addresses[0].ip}') && echo $API_IP
```{{exec}}

Open **Terminal 2** and watch Pod creation before submitting:

```
kubectl get pods --watch
```{{exec T2}}

Submit the job directly from the host. Because `spark-submit` runs natively here, it uses the existing kubeconfig and trusts the cluster CA automatically:

```
spark-submit --master k8s://https://$API_IP:6443 --deploy-mode cluster --name spark-k8s-job --conf spark.executor.instances=1 --conf spark.kubernetes.container.image=localhost:5000/spark-app:latest --conf spark.kubernetes.namespace=default --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa --conf spark.kubernetes.driver.pod.name=spark-driver --conf spark.kubernetes.driver.deletionGracePeriodSeconds=3600 local:///opt/spark/work-dir/job.py
```{{exec}}

Watch Terminal 2 — you will see the Driver Pod appear (`Running`), then one Executor Pod. The Executor is deleted automatically when the job completes. The Driver Pod stays in `Completed` state.

Press **Ctrl+C** in Terminal 2 to stop watching, then continue to the next step.
