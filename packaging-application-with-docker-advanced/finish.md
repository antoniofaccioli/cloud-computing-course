# Exercise complete

**Cloud Computing and Distributed Systems**
Università degli Studi di Verona — A.A. 2025/2026

---

## What you have demonstrated

- Building and running a containerised Python application
- The impact of instruction order on Docker's layer cache
- How a multi-stage build reduces the final image size without changing application behaviour

---

## Questions for the debrief

- Why does `Dockerfile.v1` cause `pip install` to re-run on every code change?
- What is the practical impact of this in a team that pushes code many times a day?
- What was the size difference between `myapp:v1` and `myapp:v3`? What accounts for it?
- In `Dockerfile.v3`, what would happen if you modified `requirements.txt`? Which stages would be rebuilt?
