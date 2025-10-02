terraform {
  required_version = "1.11.3"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.10"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

resource "azapi_resource" "bastion" {
  location  = var.location
  name      = var.name
  parent_id = var.parent_id
  tags      = var.tags
  type      = "Microsoft.Network/bastionHosts@2024-05-01"
  body = {
    sku = {
      name = var.sku
    }
    zones = var.zones
    properties = {
      disableCopyPaste         = !var.copy_paste_enabled
      enableFileCopy           = var.file_copy_enabled
      enableIpConnect          = var.ip_connect_enabled
      enableKerberos           = var.kerberos_enabled
      enablePrivateOnlyBastion = var.private_only_enabled
      enableSessionRecording   = var.session_recording_enabled
      enableShareableLink      = var.shareable_link_enabled
      enableTunneling          = var.tunneling_enabled
      ipConfigurations = [
        {
          name = "ipconfig-${var.name}"
          properties = {
            privateIPAllocationMethod = "Dynamic"
            subnet = {
              id = var.ip_configuration.subnet_id
            }
          }
        }
      ]
    }
  }
}
