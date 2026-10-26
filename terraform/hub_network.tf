# -------------------------------------------------------------------------------------------------
# Hub Virtual Network with Azure Firewall & Bastion Host
# -------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "hub_rg" {
  name     = "rg-hub-connectivity-prod"
  location = "eastus"
  tags = {
    Environment = "Production"
    Role        = "Hub-Network"
    ManagedBy   = "Azure-DevOps-Pipeline"
    Owner       = "Gunjan Kumar Gaurav"
  }
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-prod-01"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  address_space       = ["10.100.0.0/16"]

  tags = azurerm_resource_group.hub_rg.tags
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.100.0.0/24"]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.100.1.0/24"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.100.2.0/24"]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = "pip-afw-hub-prod"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = azurerm_resource_group.hub_rg.tags
}

resource "azurerm_firewall" "hub_firewall" {
  name                = "afw-hub-prod-01"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  zones               = ["1", "2", "3"]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }

  tags = azurerm_resource_group.hub_rg.tags
}
