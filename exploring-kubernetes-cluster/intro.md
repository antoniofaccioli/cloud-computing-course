# Exploring a Kubernetes cluster

In this exercise you will explore a real, running Kubernetes cluster and locate the components introduced in the lesson:

- **Control Plane**: kube-apiserver, etcd, kube-scheduler, kube-controller-manager
- **Worker Node**: kubelet, kube-proxy, container runtime
- **Pod lifecycle**: from creation to termination

The cluster is already running. No installation is required.

> The node you are logged into acts as both Control Plane and Worker Node — this is the `kubernetes-kubeadm-1node` environment.
