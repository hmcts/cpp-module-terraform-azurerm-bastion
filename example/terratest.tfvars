nsg = {
  name = "NS-MDV-BASTION-01"
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
    },
    {
      name                       = "AllowGatewayManagerInbound"
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
      description                = "Allow Gateway Manager from Internet"
    },
    {
      name                       = "AllowAzureLoadBalancerInbound"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
      description                = "Allow Azure Load Balancer from Internet"
    },
    {
      name                       = "AllowBastionHostCommunication"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080,5701"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      description                = "Allow Bastion Host Communication within VNet"
    },
    {
      name                       = "Deny_All_Inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefixes    = ["0.0.0.0/0"]
      destination_address_prefix = "*"
      description                = "Default deny from all"
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
      description                = "Allow HTTPS to AzureCloud"
    },
    {
      name                       = "AllowBastionCommunication"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080,5701"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      description                = "Allow Bastion Communication within VNet"
    },
    {
      name                       = "AllowHttpOutbound"
      priority                   = 130
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
      description                = "Allow HTTP to Internet"
    },
    {
      name                       = "Deny_All_Outbound"
      priority                   = 4096
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefixes    = ["0.0.0.0/0"]
      destination_address_prefix = "*"
      description                = "Default deny to all"
    }
  ]
}
