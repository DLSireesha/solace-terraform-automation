# VPN Outputs
output "msg_vpn_name" {
  description = "Message VPN name used for queues"
  value       = var.msg_vpn_name
}

# Queue Outputs
output "orders_queue_name" {
  description = "Orders queue name"
  value       = solacebroker_msg_vpn_queue.queue_orders.queue_name
}

output "payments_queue_name" {
  description = "Payments queue name"
  value       = solacebroker_msg_vpn_queue.queue_payments.queue_name
}

output "notifications_queue_name" {
  description = "Notifications queue name"
  value       = solacebroker_msg_vpn_queue.queue_notofications.queue_name
}

# Subscription Outputs
output "orders_subscriptions" {
  description = "Topics subscribed to Orders queue"
  value = [
    solacebroker_msg_vpn_queue_subscription.orders_subscriptions1.subscription_topic,
    solacebroker_msg_vpn_queue_subscription.orders_subscriptions2.subscription_topic
  ]
}

output "payments_subscriptions" {
  description = "Topics subscribed to Payments queue"
  value = [
    solacebroker_msg_vpn_queue_subscription.payments_subscriptions1.subscription_topic
  ]
}

output "notifications_subscriptions" {
  description = "Topics subscribed to Notifications queue"
  value = [
    solacebroker_msg_vpn_queue_subscription.notifications_subscriptions1.subscription_topic,
    solacebroker_msg_vpn_queue_subscription.notifications_subscriptions2.subscription_topic
  ]
}

output "orders_username" {
  value = solacebroker_msg_vpn_client_username.orders-app.client_username
}
output "orders_password" {
  value = solacebroker_msg_vpn_client_username.orders-app.password
  sensitive = true
}

output "payments_username" {
  value = solacebroker_msg_vpn_client_username.payments-app.client_username
}
output "payments_password" {
  value = solacebroker_msg_vpn_client_username.payments-app.password
  sensitive = true
}

output "notifications_username" {
  value = solacebroker_msg_vpn_client_username.notifications-app.client_username
}
output "notifications_password" {
  value = solacebroker_msg_vpn_client_username.notifications-app.password
  sensitive = true
}
output "broker_url" {
  value = var.solacebroker_url
}

