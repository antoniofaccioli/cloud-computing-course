## Spark MLlib — Guided exercise

In this exercise you will work with three PySpark scripts already prepared in `/root/spark-lab/data/`:

- `train_pipeline.py` — builds a four-stage MLlib Pipeline, trains it, evaluates it, and saves the model
- `serve_pipeline.py` — reloads the saved model and runs inference on new unseen data
- `joins_skew.py` — demonstrates broadcast join and salting for data skew mitigation

All scripts run inside the official `spark:python3` Docker container with a volume mount so the container can read and write to `/root/spark-lab/data/`.

Start by pulling the Spark image:

```
docker pull spark:python3
```{{exec}}
