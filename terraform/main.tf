# ----------------------------------------
# Local variables
# ----------------------------------------
locals {
  nodes = formatlist("%s.lan", keys(
      { for k, v in var.nodes : k => k }
    )
  )
}

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
  nodes                = local.nodes
}

# ----------------------------------------
# Generate machine configurations
# ----------------------------------------
data "talos_machine_configuration" "this" {
  for_each = var.nodes

  cluster_endpoint = var.cluster_endpoint
  cluster_name     = var.cluster_name
  docs             = false
  examples         = false
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  machine_type     = each.value.type

  config_patches = [
    templatefile("${path.module}/patches/${each.value.model}-network.yaml", {
      hostname = each.key
      vip      = var.cluster_vip
    })
  ]
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
