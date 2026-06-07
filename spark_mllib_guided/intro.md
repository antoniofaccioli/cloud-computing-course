## Spark MLlib — Guided exercise

In this exercise you will work with three PySpark scripts already prepared in `/root/spark-lab/data/`:

- `train_pipeline.py` — builds a four-stage MLlib Pipeline, trains it, evaluates it, and saves the model
- `serve_pipeline.py` — reloads the saved model and runs inference on new unseen data
- `joins_skew.py` — demonstrates broadcast join and salting for data skew mitigation

The environment setup (running in the background) has already built a custom Docker image called `spark-mllib:latest`. It extends the official `spark:python3` image by adding `numpy`, which is required by MLlib.

Verify the image is ready:

```
docker images spark-mllib
```{{exec}}

You should see `spark-mllib` with tag `latest`. If the image is not yet listed, wait a few seconds and run the command again.
