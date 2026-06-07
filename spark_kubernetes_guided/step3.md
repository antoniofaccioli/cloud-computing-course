## Step 3 — Submit the Spark job

Get the Kubernetes API server IP and save it:

```
export API_IP=$(kubectl get endpoints kubernetes -o jsonpath='{.subsets[0].addresses[0].ip}')
echo $API_IP
```{{exec}}

Submit the job. The spark-submit command runs inside the Spark container with the kubeconfig mounted so it can reach the cluster API:

```
docker run --rm --network host -v /root/.kube:/root/.kube localhost:5000/spark-app:latest /opt/spark/bin/spark-submit --master k8s://https://$API_IP:6443 --deploy-mode cluster --name spark-k8s-job --conf spark.executor.instances=1 --conf spark.kubernetes.container.image=localhost:5000/spark-app:latest --conf spark.kubernetes.namespace=default --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-sa --conf spark.kubernetes.driver.pod.name=spark-driver local:///opt/spark/work-dir/job.py
```{{exec}}

Watch the Pods being created in a second terminal:

```
watch kubectl get pods
```{{exec T2}}
