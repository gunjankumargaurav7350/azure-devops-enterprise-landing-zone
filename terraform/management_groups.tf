# -------------------------------------------------------------------------------------------------
# Enterprise Cloud Adoption Framework (CAF) Management Group Structure
# -------------------------------------------------------------------------------------------------
resource "azurerm_management_group" "root" {
  display_name               = "Enterprise-Root-LandingZone"
  name                       = "mg-enterprise-root"
  subscription_ids           = []
}

resource "azurerm_management_group" "platform" {
  display_name               = "Platform"
  name                       = "mg-platform"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "landing_zones" {
  display_name               = "Landing-Zones"
  name                       = "mg-landingzones"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "sandboxes" {
  display_name               = "Decommissioned-and-Sandboxes"
  name                       = "mg-sandboxes"
  parent_management_group_id = azurerm_management_group.root.id
}
