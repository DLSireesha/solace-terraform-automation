resource "solacecloud_service" "dev_service" {
  name = "Solace-Devops-Pubsub"
  datacenter_id    = "eks-eu-central-1a"
}