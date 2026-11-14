variable "root_name" {
  type        = string
  description = "Root Management Group Name"
  default     = "mg-enterprise-root"
}

variable "root_display_name" {
  type        = string
  description = "Root Management Group Display Name"
  default     = "Enterprise-Root-LandingZone"
}

variable "root_subscription_ids" {
  type        = list(string)
  description = "Subscription IDs associated with root management group"
  default     = []
}

variable "child_management_groups" {
  type = map(object({
    display_name     = string
    subscription_ids = optional(list(string), [])
  }))
  description = "Map of child management groups structured with for_each"
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
