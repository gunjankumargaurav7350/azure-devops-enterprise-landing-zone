output "root_management_group_id" {
  description = "Root Management Group ID"
  value       = azurerm_management_group.root.id
}

output "child_management_groups" {
  description = "Map of child management group IDs"
  value       = { for k, v in azurerm_management_group.children : k => v.id }
}
