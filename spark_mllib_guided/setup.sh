#!/bin/bash
mkdir -p /root/spark-lab/data

# Build custom Spark image with numpy (required by MLlib)
cat > /root/spark-lab/Dockerfile << 'DOCKEREOF'
FROM spark:python3
RUN pip install numpy --quiet
DOCKEREOF

docker build -t spark-mllib:latest /root/spark-lab/

cat > /root/spark-lab/data/train_pipeline.py << 'PY1EOF'
from pyspark.sql import SparkSession
from pyspark.ml import Pipeline
from pyspark.ml.feature import StringIndexer, VectorAssembler, StandardScaler
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.evaluation import BinaryClassificationEvaluator
from pyspark.sql.types import StructType, StructField, StringType, DoubleType, IntegerType

spark = SparkSession.builder.appName("TrainPipeline").getOrCreate()
spark.sparkContext.setLogLevel("ERROR")

schema = StructType([
    StructField("category", StringType()),
    StructField("amount", DoubleType()),
    StructField("frequency", IntegerType()),
    StructField("label", DoubleType())
])

data = spark.createDataFrame([
    ("A", 120.0, 5, 0.0), ("B", 850.0, 1, 1.0), ("A", 45.0, 8, 0.0),
    ("C", 920.0, 1, 1.0), ("B", 200.0, 4, 0.0), ("C", 1100.0, 1, 1.0),
    ("A", 60.0, 7, 0.0), ("B", 750.0, 2, 1.0), ("A", 90.0, 6, 0.0),
    ("C", 980.0, 1, 1.0), ("B", 300.0, 3, 0.0), ("A", 50.0, 9, 0.0),
    ("C", 870.0, 2, 1.0), ("B", 400.0, 3, 0.0), ("A", 70.0, 7, 0.0),
    ("C", 1050.0, 1, 1.0), ("B", 250.0, 4, 0.0), ("A", 80.0, 6, 0.0),
    ("C", 990.0, 1, 1.0), ("B", 600.0, 2, 0.0)
], schema=schema)

train, test = data.randomSplit([0.8, 0.2], seed=42)
print(f"Training rows: {train.count()}, Test rows: {test.count()}")

indexer = StringIndexer(inputCol="category", outputCol="cat_index")
assembler = VectorAssembler(inputCols=["cat_index", "amount", "frequency"], outputCol="raw_features")
scaler = StandardScaler(inputCol="raw_features", outputCol="features")
lr = LogisticRegression(labelCol="label", featuresCol="features")

pipeline = Pipeline(stages=[indexer, assembler, scaler, lr])
model = pipeline.fit(train)

predictions = model.transform(test)
predictions.select("category", "amount", "frequency", "label", "prediction", "probability").show(truncate=False)

evaluator = BinaryClassificationEvaluator(labelCol="label")
auc = evaluator.evaluate(predictions)
print(f"AUC on test set: {auc:.3f}")

model.write().overwrite().save("/data/fraud_pipeline_model")
print("Model saved to /data/fraud_pipeline_model")
spark.stop()
PY1EOF

cat > /root/spark-lab/data/serve_pipeline.py << 'PY2EOF'
from pyspark.sql import SparkSession
from pyspark.ml import PipelineModel
from pyspark.sql.types import StructType, StructField, StringType, DoubleType, IntegerType

spark = SparkSession.builder.appName("ServePipeline").getOrCreate()
spark.sparkContext.setLogLevel("ERROR")

model = PipelineModel.load("/data/fraud_pipeline_model")
print("Model loaded successfully")

schema = StructType([
    StructField("category", StringType()),
    StructField("amount", DoubleType()),
    StructField("frequency", IntegerType())
])

new_data = spark.createDataFrame([
    ("A", 55.0, 8),
    ("B", 900.0, 1),
    ("C", 1200.0, 1),
    ("A", 100.0, 6),
    ("B", 500.0, 2)
], schema=schema)

predictions = model.transform(new_data)
predictions.select("category", "amount", "frequency", "prediction", "probability").show(truncate=False)
spark.stop()
PY2EOF

cat > /root/spark-lab/data/joins_skew.py << 'PY3EOF'
from pyspark.sql import SparkSession
from pyspark.sql.functions import broadcast, sum as _sum, count, rand, concat, lit, explode, array, col
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType

spark = SparkSession.builder.appName("JoinsAndSkew").getOrCreate()
spark.sparkContext.setLogLevel("ERROR")

events_schema = StructType([
    StructField("country", StringType()),
    StructField("user_id", IntegerType()),
    StructField("amount", DoubleType())
])

profiles_schema = StructType([
    StructField("country", StringType()),
    StructField("region", StringType())
])

events = spark.createDataFrame(
    [("US", i, float(i * 10)) for i in range(1, 91)] +
    [("IT", i + 90, float(i * 5)) for i in range(1, 6)] +
    [("DE", i + 95, float(i * 8)) for i in range(1, 6)],
    events_schema
)

profiles = spark.createDataFrame([
    ("US", "North America"),
    ("IT", "Europe"),
    ("DE", "Europe")
], profiles_schema)

print("=== Key distribution ===")
events.groupBy("country").count().orderBy("count", ascending=False).show()

print("=== Broadcast join result ===")
events.join(broadcast(profiles), "country").groupBy("country", "region").agg(
    _sum("amount").alias("total"),
    count("user_id").alias("users")
).show()

print("=== Same join with salting (N=5) ===")
N = 5
events_salted = events.withColumn("salt", (rand(seed=42) * N).cast("int"))
events_salted = events_salted.withColumn("key_s", concat(col("country"), lit("_"), col("salt").cast("string")))

profiles_exploded = profiles.withColumn("salt", explode(array([lit(i) for i in range(N)])))
profiles_exploded = profiles_exploded.withColumn("key_s", concat(col("country"), lit("_"), col("salt").cast("string")))

result_salted = events_salted.join(profiles_exploded, "key_s").drop("salt", "key_s")
result_salted.groupBy("country", "region").agg(
    _sum("amount").alias("total"),
    count("user_id").alias("users")
).orderBy("country").show()

print("Results are identical — salting distributes load without changing output.")
spark.stop()
PY3EOF
