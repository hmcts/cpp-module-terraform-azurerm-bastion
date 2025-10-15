private_only_enabled = true

nsg = {
  name = "NS-MDV-BASTION-01" # This name is not used anymore, but the object structure is needed.
  custom_rules = [
    # Inbound
    {
      name                       = "AllowAdminVPNInbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefixes    = ["10.88.112.0/27"]
      destination_address_prefix = "*"
      description                = "Allow HTTPS from AdminVPN subnet"
    }
  ]
}