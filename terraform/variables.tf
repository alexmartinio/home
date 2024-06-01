variable "cluster_endpoint" {
  description = "The endpoint of the Talos Kubernetes cluster."
  type = string
  default = "https://turingpi-cluster.lan:6443"
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
  default     = "turingpi-cluster"
}

variable "nodes" {
  description = "A list of node for the Talos Client Configuration."
  type        = list(string)
  default = [
    "node1.lan",
    "node2.lan",
    "node3.lan",
    "node4.lan"
  ]
}