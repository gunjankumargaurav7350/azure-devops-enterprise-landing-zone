variable "resource_group_name" {
  type        = string
  description = "Resource Group Name for Hub Connectivity"
  default     = "rg-hub-connectivity-prod"
}

variable "location" {
  type        = string
  description = "Azure Region for Hub Network"
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "Default resource tags"
  default = {
    Environment = "Production"
    Role        = "Hub-Network"
    ManagedBy   = "Azure-DevOps-Pipeline"
    Owner       = "Gunjan Kumar Gaurav"
  }
}

variable "hub_networks" {
  type = map(object({
    address_space     = list(string)
    enable_firewall   = optional(bool, true)
    firewall_name     = optional(string, "afw-hub-prod-01")
    firewall_sku_tier = optional(string, "Standard")
    tags              = optional(map(string), {})
    subnets = map(object({
      address_prefixes = list(string)
    }))
  }))
  description = "Map of hub networks configured with for_each"
  default = {
    "vnet-hub-prod-01" = {
      address_space     = ["10.100.0.0/16"]
      enable_firewall   = true
      firewall_name     = "afw-hub-prod-01"
      firewall_sku_tier = "Standard"
      subnets = {
        "AzureFirewallSubnet" = {
          address_prefixes = ["10.100.0.0/24"]
        }
        "AzureBastionSubnet" = {
          address_prefixes = ["10.100.1.0/24"]
        }
        "GatewaySubnet" = {
          address_prefixes = ["10.100.2.0/24"]
        }
      }
    }
  }
}

variable "root_management_group_name" {
  type        = string
  description = "Root Management Group Name"
  default     = "mg-enterprise-root"
}

variable "root_management_group_display_name" {
  type        = string
  description = "Root Management Group Display Name"
  default     = "Enterprise-Root-LandingZone"
}

variable "root_subscription_ids" {
  type        = list(string)
  description = "Subscription IDs for root management group"
  default     = []
}

variable "child_management_groups" {
  type = map(object({
    display_name     = string
    subscription_ids = optional(list(string), [])
  }))
  description = "Child management groups created with for_each"
  default = {
    "mg-platform" = {
      display_name = "Platform"
    }
    "mg-landingzones" = {
      display_name = "Landing-Zones"
    }
    "mg-sandboxes" = {
      display_name = "Decommissioned-and-Sandboxes"
    }
  }
}
