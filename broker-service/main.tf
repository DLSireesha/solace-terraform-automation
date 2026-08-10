resource "solacebroker_msg_vpn_queue" "queue_orders" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Orders"
    access_type = "exclusive"
    max_msg_spool_usage = 500
    dead_msg_queue = "Queue_Orders.DMQ"
    ingress_enabled = true
    egress_enabled = true
    max_msg_size = 10000000
    max_ttl = 3600
    redelivery_enabled = true
    max_redelivery_count = 5
}
resource "solacebroker_msg_vpn_queue" "dmq_orders" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Orders.DMQ"
    max_msg_spool_usage = 5000
}

resource "solacebroker_msg_vpn_queue_subscription" "orders_subscriptions1" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Orders"
    subscription_topic = "topic/orders/created"
    depends_on = [solacebroker_msg_vpn_queue.queue_orders]
}
resource "solacebroker_msg_vpn_queue_subscription" "orders_subscriptions2" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Orders"
    subscription_topic = "topic/orders/updated"
    depends_on = [solacebroker_msg_vpn_queue.queue_orders]
}

resource "solacebroker_msg_vpn_queue" "queue_payments" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Payments"
    access_type = "exclusive"
    max_msg_spool_usage = 500
    dead_msg_queue = "Queue_Payments.DMQ"
    ingress_enabled = true
    egress_enabled = true
    max_msg_size = 10000000
    max_ttl = 3600
    redelivery_enabled = true
    max_redelivery_count = 5
}
resource "solacebroker_msg_vpn_queue" "dmq_payments" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Payments.DMQ"
    max_msg_spool_usage = 5000
}
resource "solacebroker_msg_vpn_queue_subscription" "payments_subscriptions1" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Payments"
    subscription_topic = "topic/payments/processed"
    depends_on = [solacebroker_msg_vpn_queue.queue_payments]
}

resource "solacebroker_msg_vpn_queue" "queue_notofications" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Notifications"
    access_type = "exclusive"
    max_msg_spool_usage = 500
    dead_msg_queue = "Queue_Notifications.DMQ"
    ingress_enabled = true
    egress_enabled = true
    max_msg_size = 10000000
    max_ttl = 3600
    redelivery_enabled = true
    max_redelivery_count = 5
}
resource "solacebroker_msg_vpn_queue" "dmq_Notifications" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Notifications.DMQ"
    max_msg_spool_usage = 5000
}
resource "solacebroker_msg_vpn_queue_subscription" "notifications_subscriptions1" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Notifications"
    subscription_topic = "topic/notifications/email"
    depends_on = [solacebroker_msg_vpn_queue.queue_notofications]
}

resource "solacebroker_msg_vpn_queue_subscription" "notifications_subscriptions2" {
    msg_vpn_name = var.msg_vpn_name
    queue_name = "Queue_Notifications"
    subscription_topic = "topic/notifications/sms"
    depends_on = [solacebroker_msg_vpn_queue.queue_notofications]
}


