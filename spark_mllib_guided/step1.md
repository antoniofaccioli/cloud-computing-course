## Step 1 — Verify the scripts

Inspect the training script to understand the pipeline structure:

```
cat /root/spark-lab/data/train_pipeline.py
```{{exec}}

The pipeline has four stages:

1. `StringIndexer` — converts the string column `category` into a numeric index
2. `VectorAssembler` — merges `cat_index`, `amount`, and `frequency` into a single feature vector
3. `StandardScaler` — normalises the feature magnitudes
4. `LogisticRegression` — the binary classifier with `label` as the target column

Inspect the serving script:

```
cat /root/spark-lab/data/serve_pipeline.py
```{{exec}}

Notice that `serve_pipeline.py` has no knowledge of the pipeline stages — it simply calls `PipelineModel.load()` and `model.transform()`. The stage configuration and fitted weights are entirely contained in the saved model directory.
