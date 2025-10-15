terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "suffix" {
  length = 2
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${random_pet.suffix.id}"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${random_pet.suffix.id}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${random_pet.suffix.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.nsg.custom_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

module "azure_bastion" {
  source = "../"

  location           = azurerm_resource_group.rg.location
  name               = "bastion-${random_pet.suffix.id}"
  copy_paste_enabled = true
  file_copy_enabled  = true
  ip_configuration = {
    subnet_id        = azurerm_subnet.bastion.id
    create_public_ip = false
  }
  ip_connect_enabled        = true
  kerberos_enabled          = true
  private_only_enabled      = var.private_only_enabled
  session_recording_enabled = false
  shareable_link_enabled    = true
  sku                       = "Premium"
  tunneling_enabled         = true
  parent_id                 = azurerm_resource_group.rg.id
  tags                      = {}
}

output "bastion_name" {
  value = module.azure_bastion.name
}