#!/bin/bash

until kubectl get nodes | grep -q " Ready"; do sleep 3; done

# Install Java (required by spark-submit)
apt-get install -y default-jdk-headless 2>/dev/null

# Download and install Spark on the host so spark-submit runs natively
curl -sL https://archive.apache.org/dist/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz | tar xz -C /opt/
ln -s /opt/spark-3.5.3-bin-hadoop3 /opt/spark
export PATH=$PATH:/opt/spark/bin
echo 'export PATH=$PATH:/opt/spark/bin' >> /root/.bashrc

# Start local registry
docker run -d -p 5000:5000 --name registry registry:2

# Create app directory
mkdir -p /root/spark-app

cat > /root/spark-app/Dockerfile << 'DOCKEREOF'
FROM spark:python3
COPY job.py /opt/spark/work-dir/job.py
DOCKEREOF

cat > /root/spark-app/job.py << 'PYEOF'
from pyspark.sql import SparkSession
from pyspark.sql.functions import broadcast, sum as _sum, count
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType

spark = SparkSession.builder.appName("SparkOnK8s").getOrCreate()
spark.sparkContext.setLogLevel("ERROR")

events_schema = StructType([
    StructField("event_id", IntegerType()),
    StructField("product_id", StringType()),
    StructField("amount", DoubleType())
])

products_schema = StructType([
    StructField("product_id", StringType()),
    StructField("category", StringType())
])

events = spark.createDataFrame([
    (1, "P001", 25.0), (2, "P002", 80.0), (3, "P001", 25.0),
    (4, "P003", 150.0), (5, "P002", 80.0), (6, "P003", 150.0)
], events_schema)

products = spark.createDataFrame([
    ("P001", "electronics"),
    ("P002", "clothing"),
    ("P003", "electronics")
], products_schema)

print("=== Revenue by category (broadcast join) ===")
events.join(broadcast(products), "product_id").groupBy("category").agg(
    _sum("amount").alias("total_revenue"),
    count("event_id").alias("num_events")
).show()

spark.stop()
PYEOF

cat > /root/spark-app/rbac.yaml << 'YAMLEOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: spark-sa
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: spark-role
  namespace: default
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "configmaps"]
    verbs: ["create", "get", "list", "watch", "delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: spark-rolebinding
  namespace: default
subjects:
  - kind: ServiceAccount
    name: spark-sa
    namespace: default
roleRef:
  kind: Role
  name: spark-role
  apiGroup: rbac.authorization.k8s.io
YAMLEOF
