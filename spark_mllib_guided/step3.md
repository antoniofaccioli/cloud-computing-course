## Step 3 — Load the model and run inference

Run the serving script. It loads the model saved in Step 2 and applies it to five new transactions that were never seen during training:

```
docker run --rm -v /root/spark-lab/data:/data spark:python3 /opt/spark/bin/spark-submit /data/serve_pipeline.py
```{{exec}}

The output shows `prediction` (0.0 = legitimate, 1.0 = fraudulent) and `probability` for each transaction.

Examine the predictions: the high-amount, low-frequency transactions (category B and C with amount > 800) should be predicted as fraudulent, while low-amount, high-frequency ones (category A) should be predicted as legitimate.

This is the core of MLlib model persistence: the `PipelineModel` is a self-contained artefact. The serving environment does not need to know which stages were used or how the model was trained — it just loads and transforms.
