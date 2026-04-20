# Well done

You have explored a real Kubernetes cluster and located every component discussed in the lesson:

- The **Control Plane** pods running in `kube-system`
- The **API Server**, **etcd**, **Scheduler**, and **Controller Manager** as static pods
- The **kubelet** and **kube-proxy** running as daemons on the node
- The full **lifecycle of a Pod**: Pending → Running → Terminating → gone

In the next lesson you will move from observing existing resources to creating your own: writing Pod manifests in YAML and applying them to the cluster.
