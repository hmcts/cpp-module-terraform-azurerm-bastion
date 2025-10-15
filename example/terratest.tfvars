private_only_enabled = true

nsg = {
  name = "NS-MDV-BASTION-01" # This name is not used anymore, but the object structure is needed.
  custom_rules = [
    # Inbound
    {
      name                       = "AllowHttpsInbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
      description                = "Allow HTTPS from Internet"
    },
    {
      name                       = "AllowGatewayManagerInbound"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
      description                = "Allow Gateway Manager from Internet"
    },
    {
      name                       = "AllowAzureCloudInbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureCloud"
      destination_address_prefix = "*"
      description                = "Allow AzureCloud"
    },
    {
      name                       = "AllowBastionHostCommunicationInbound"
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080,5701"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      description                = "Allow Bastion Host Communication"
    },
    # Outbound
    {
      name                       = "AllowSshRdpOutbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22,3389"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
      description                = "Allow SSH and RDP to Virtual Network"
    },
    {
      name                       = "AllowAzureCloudOutbound"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureCloud"
      description                = "Allow AzureCloud"
    },
    {
      name                       = "AllowBastionHostCommunicationOutbound"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080,5701"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      description                = "Allow Bastion Host Communication"
    },
    {
      name                       = "AllowHttpOutbound"
      priority                   = 130
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
      description                = "Allow HTTP to Internet"
    }
  ]
}
