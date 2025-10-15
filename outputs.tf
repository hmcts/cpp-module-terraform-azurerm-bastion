output "id" {
  description = "The ID of the Bastion Host."
  value       = azapi_resource.bastion.id
}

output "name" {
  description = "The name of the Bastion Host."
  value       = azapi_resource.bastion.name
}

output "dns_name" {
  description = "The DNS name of the Bastion Host."
  value       = jsondecode(azapi_resource.bastion.output).properties.dnsName
}

output "ip_configurations" {
  description = "The IP configurations of the Bastion Host."
  value       = jsondecode(azapi_resource.bastion.output).properties.ipConfigurations
}
