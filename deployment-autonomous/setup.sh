#!/bin/bash

echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Available deployment/coredns -n kube-system --timeout=120s 2>/dev/null || true

echo "Environment ready. No manifest files are pre-loaded — write your own."
echo "Refer to the objectives in the exercise steps."
