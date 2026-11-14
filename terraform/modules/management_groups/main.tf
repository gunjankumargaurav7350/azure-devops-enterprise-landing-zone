resource "azurerm_management_group" "root" {
  name             = var.root_name
  display_name     = var.root_display_name
  subscription_ids = var.root_subscription_ids
}

resource "azurerm_management_group" "children" {
  for_each                   = var.child_management_groups
  name                       = each.key
  display_name               = each.value.display_name
  subscription_ids           = each.value.subscription_ids
  parent_management_group_id = azurerm_management_group.root.id
}
