# Solace Cloud Service Outputs
output "cloud_service_name" {
  description = "Name of the Solace Cloud service"
  value       = solacecloud_service.dev_service.name
}

output "cloud_service_id" {
  description = "ID of the Solace Cloud service"
  value       = solacecloud_service.dev_service.id
}