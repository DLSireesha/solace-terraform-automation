# Solace Broker provider variables
variable "solacebroker_username" {
  type        = string
  description = "Broker management username"
}
variable "solacebroker_password" {
  type        = string
  description = "Broker management password"
  sensitive   = true
}
variable "solacebroker_url" {
  type        = string
  description = "SEMP management URL for Solace broker"
}

# VPN name
variable "msg_vpn_name" {
  type        = string
  description = "Message VPN name"
}