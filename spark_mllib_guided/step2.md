## Step 2 — Train and save the Pipeline

Run the training script:

```
docker run --rm -v /root/spark-lab/data:/data spark-mllib:latest /opt/spark/bin/spark-submit /data/train_pipeline.py
```{{exec}}

You should see:
- The training and test row counts
- A predictions table with `category`, `amount`, `frequency`, `label`, `prediction`, and `probability` columns
- The AUC score on the test set
- The confirmation that the model was saved

Inspect the saved model directory:

```
ls /root/spark-lab/data/fraud_pipeline_model/
```{{exec}}

```
ls /root/spark-lab/data/fraud_pipeline_model/stages/
```{{exec}}

Each numbered subdirectory corresponds to one fitted stage. The directory contains everything needed to reconstruct the full Transformer chain — no re-training required.
