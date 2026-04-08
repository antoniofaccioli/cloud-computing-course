from flask import Flask, jsonify
import json, os

app = Flask(__name__)
DATA_FILE = "/data/counter.json"

def read_count():
    if os.path.exists(DATA_FILE):
        with open(DATA_FILE) as f:
            return json.load(f).get("count", 0)
    return 0

def write_count(n):
    os.makedirs("/data", exist_ok=True)
    with open(DATA_FILE, "w") as f:
        json.dump({"count": n}, f)

@app.route("/")
def index():
    count = read_count()
    return jsonify({"visits": count, "message": "Hello from the counter app"})

@app.route("/increment")
def increment():
    count = read_count() + 1
    write_count(count)
    return jsonify({"visits": count})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
