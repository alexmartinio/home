variable "cluster_endpoint" {
  description = "The endpoint of the Talos Kubernetes cluster."
  type        = string
  default     = "https://turingpi-cluster.lan:6443"
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
  default     = "turingpi-cluster"
}

variable "cluster_vip" {
  description = "The Virtual IP Address of the Cluster (VIP)"
  type = string
  default = "192.168.50.205"
}

variable "nodes" {
  description = "A list of node for the Talos Client Configuration."
  type = map(object(
    {
      type  = string
      model = string
    }
  ))
  default = {
    node1 = {
      type  = "controlplane"
      model = "cm4"
    },
    node2 = {
      type  = "controlplane"
      model = "rk1"
    },
    node3 = {
      type  = "controlplane"
      model = "cm4"
    },
    node4 = {
      type  = "worker"
      model = "rk1"
    },
  }
}

