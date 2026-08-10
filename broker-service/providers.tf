terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
      version = "1.3.0"
    }
  }
}

provider "solacebroker" {
    username = var.solacebroker_username
    password = var.solacebroker_password
    url = var.solacebroker_url
}