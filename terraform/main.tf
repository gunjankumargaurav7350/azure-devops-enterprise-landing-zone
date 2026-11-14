terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "landingzone_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -------------------------------------------------------------------------------------------------
# Modular Hub Networks using for_each
# -------------------------------------------------------------------------------------------------
module "hub_networks" {
  source   = "./modules/hub_network"
  for_each = var.hub_networks

  resource_group_name = azurerm_resource_group.landingzone_rg.name
  location            = azurerm_resource_group.landingzone_rg.location
  vnet_name           = each.key
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  enable_firewall     = each.value.enable_firewall
  firewall_name       = each.value.firewall_name
  firewall_sku_tier   = each.value.firewall_sku_tier
  tags                = merge(azurerm_resource_group.landingzone_rg.tags, each.value.tags)
}

# -------------------------------------------------------------------------------------------------
# Modular Management Groups Hierarchy
# -------------------------------------------------------------------------------------------------
module "management_groups" {
  source = "./modules/management_groups"

  root_name               = var.root_management_group_name
  root_display_name       = var.root_management_group_display_name
  root_subscription_ids   = var.root_subscription_ids
  child_management_groups = var.child_management_groups
}
