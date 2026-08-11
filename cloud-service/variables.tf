variable "solacecloud_api_token" {
  description = "API token for Solace Cloud"
  type        = string
  sensitive   = true
}

variable "solacecloud_base_url" {
  description = "Base URL for Solace Cloud API"
  type        = string
  default     = "https://api.solace.cloud/v2"
}

variable "api_polling_interval" {
  description = "Polling interval for Solace Cloud API"
  type        = number
  default     = 30
}
