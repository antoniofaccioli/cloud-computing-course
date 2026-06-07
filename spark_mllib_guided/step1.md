## Step 1 — Build the Spark MLlib image

The `spark:python3` base image does not include `numpy`, which is required by MLlib. Build a custom image that adds it:

```
docker build -t spark-mllib:latest /root/spark-lab/
```{{exec}}

This takes about a minute. When it completes, verify the image exists:

```
docker images spark-mllib
```{{exec}}

You should see `spark-mllib` with tag `latest` and a size around 1.5 GB.

Now inspect the training script to understand the pipeline structure:

```
cat /root/spark-lab/data/train_pipeline.py
```{{exec}}

The pipeline has four stages: `StringIndexer` → `VectorAssembler` → `StandardScaler` → `LogisticRegression`. Each stage is either a Transformer or an Estimator. When `Pipeline.fit()` is called, Spark fits each Estimator stage in order and produces a `PipelineModel`.
