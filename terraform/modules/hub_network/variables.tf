variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "address_space" {
  type        = list(string)
  description = "Virtual Network Address Space"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Map of subnets to create with for_each"
  default     = {}
}

variable "enable_firewall" {
  type        = bool
  description = "Whether to provision Azure Firewall in the hub"
  default     = true
}

variable "firewall_name" {
  type        = string
  description = "Azure Firewall Name"
  default     = "afw-hub-prod-01"
}

variable "firewall_sku_tier" {
  type        = string
  description = "Azure Firewall SKU Tier"
  default     = "Standard"
}

variable "tags" {
  type        = map(string)
  description = "Tags for hub network resources"
  default     = {}
}
