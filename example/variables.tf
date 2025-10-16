variable "private_only_enabled" {
  type        = bool
  default     = true
  description = "Enable private-only Bastion (default: true)"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "nsg" {
  type = object({
    custom_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefixes    = optional(list(string))
      source_address_prefix      = optional(string)
      destination_address_prefix = string
      description                = string
    }))
  })
  description = "Bastion NSG"
}
