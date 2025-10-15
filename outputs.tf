output "id" {
  description = "The ID of the Bastion Host."
  value       = azapi_resource.bastion.id
}

output "name" {
  description = "The name of the Bastion Host."
  value       = azapi_resource.bastion.name
}

output "ip_configurations" {
  description = "The IP configurations of the Bastion Host."
  value       = azapi_resource.bastion.output.properties.ipConfigurations
}
