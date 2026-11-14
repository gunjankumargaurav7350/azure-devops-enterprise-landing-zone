output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}

output "firewall_id" {
  description = "Azure Firewall ID"
  value       = var.enable_firewall ? azurerm_firewall.firewall[0].id : null
}
