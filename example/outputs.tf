output "id" {
  description = "The ID of the Bastion Host."
  value       = module.azure_bastion.id
}

output "name" {
  description = "The name of the Bastion Host."
  value       = module.azure_bastion.name
}

output "ip_configurations" {
  description = "The IP configurations of the Bastion Host."
  value       = module.azure_bastion.ip_configurations
}
