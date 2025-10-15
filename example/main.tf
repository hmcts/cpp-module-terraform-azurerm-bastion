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

module "subnet_bastion" {
  source                   = "github.com/hmcts/cpp-module-terraform-azurerm-subnet.git?ref=4.x"
  subnet_name              = "AzureBastionSubnet"
  core_resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name     = azurerm_virtual_network.vnet.name
  subnet_address_prefixes  = ["10.0.1.0/24"]
}

module "nsg_bastion" {
  source              = "git::https://github.com/hmcts/cpp-module-terraform-azurerm-network-security-group.git?ref=main"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  security_group_name = "nsg-${random_pet.suffix.id}"
  custom_rules        = var.nsg.custom_rules
  tags                = {}
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = module.subnet_bastion.id
  network_security_group_id = module.nsg_bastion.network_security_group_id
}

module "azure_bastion" {
  source     = "../"
  depends_on = [azurerm_subnet_network_security_group_association.bastion]

  location           = azurerm_resource_group.rg.location
  name               = "bastion-${random_pet.suffix.id}"
  copy_paste_enabled = true
  file_copy_enabled  = true
  ip_configuration = {
    subnet_id        = module.subnet_bastion.id
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
