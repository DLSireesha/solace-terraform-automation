terraform {
  required_providers {
    solacecloud = {
    source  = "SolaceProducts/solacecloud"
    version = "0.2.2"
    }
  }
}
provider "solacecloud" {
  base_url = var.solacecloud_base_url
  api_token = var.solacecloud_api_token
  api_polling_interval = var.api_polling_interval
}