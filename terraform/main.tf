# ----------------------------------------
# Generate machine secrets for Talos cluster
# ----------------------------------------
resource "talos_machine_secrets" "this" {}

# ----------------------------------------
# Generate client configuration for a Talos cluster
# ----------------------------------------
data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = var.nodes
}

# ----------------------------------------
# Generate machine configurations
# ----------------------------------------
data "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster_name
  machine_type     = "controlplane"
  cluster_endpoint = var.cluster_endpoint
  machine_secrets  = talos_machine_secrets.this.machine_secrets

  config_patches = []
}

# ----------------------------------------
# Get disks for each node
# ----------------------------------------
# data "talos_machine_disks" "this" {
#   for_each = toset(var.nodes)

#   client_configuration = talos_machine_secrets.this.client_configuration
#   node                 = each.value

#   filters = {
#     size = "> 100GB"
#     type = "nvme"
#   }
# }