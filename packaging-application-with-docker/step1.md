# Step 1 — Explore the application

Move into the working directory:

```
cd /root/app
```

List the files:

```
ls -la
```

You will see:
- `app.py` — the Python application (you do not need to read it)
- `requirements.txt` — the list of dependencies the application needs
- `Dockerfile.v1`, `Dockerfile.v2`, `Dockerfile.v3` — three versions of the Dockerfile

Read the dependency file:

```
cat requirements.txt
```

There is one dependency: **Flask**, a Python web framework. This is what `pip install` will download when Docker builds the image.

---

Now read the first Dockerfile:

```
cat Dockerfile.v1
```

You will see six instructions. Here is what each one does:

| Instruction | What it does |
|---|---|
| `FROM python:3.11-slim` | Start from an official Python base image |
| `WORKDIR /app` | Set the working directory inside the container |
| `COPY . .` | Copy all files from the host into the container |
| `RUN pip install ...` | Install the Python dependencies — this creates a layer |
| `EXPOSE 5000` | Document that the container listens on port 5000 |
| `CMD ["python", "app.py"]` | The command to run when the container starts |

---

> **Question before you continue:** looking at the order of instructions in `Dockerfile.v1` — if you changed one line of `app.py` and rebuilt the image, which instructions do you think Docker would re-execute?

Think about your answer, then click **NEXT**.
