output "hub_networks" {
  description = "Hub Networks and subnets provisioned via modular for_each"
  value = {
    for k, v in module.hub_networks : k => {
      vnet_id     = v.vnet_id
      vnet_name   = v.vnet_name
      subnet_ids  = v.subnet_ids
      firewall_id = v.firewall_id
    }
  }
}

output "root_management_group_id" {
  description = "Root CAF Management Group ID"
  value       = module.management_groups.root_management_group_id
}

output "child_management_groups" {
  description = "Child CAF Management Groups structured via for_each"
  value       = module.management_groups.child_management_groups
}
