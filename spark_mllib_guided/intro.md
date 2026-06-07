## Spark MLlib — Guided exercise

In this exercise you will work with three PySpark scripts already prepared in `/root/spark-lab/data/`:

- `train_pipeline.py` — builds a four-stage MLlib Pipeline, trains it, evaluates it, and saves the model
- `serve_pipeline.py` — reloads the saved model and runs inference on new unseen data
- `joins_skew.py` — demonstrates broadcast join and salting for data skew mitigation

MLlib requires `numpy`, which is not included in the base `spark:python3` image. The first step will build a custom image that adds it.

Verify the scripts are ready:

```
ls /root/spark-lab/data/
```{{exec}}
