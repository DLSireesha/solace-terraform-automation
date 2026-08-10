#client profiles for Orders
resource "solacebroker_msg_vpn_client_profile" "orders-profile" {
    msg_vpn_name        = var.msg_vpn_name
    client_profile_name = "Orders_Profile"
    allow_guaranteed_msg_send_enabled = true
    allow_guaranteed_msg_receive_enabled = true
    allow_guaranteed_endpoint_create_enabled = true
    max_connection_count_per_client_username = 10
}

#Client Usernames for Orders
resource "solacebroker_msg_vpn_client_username" "orders-app" {
    msg_vpn_name = var.msg_vpn_name
    client_username = "Orders_App"
    password = "orders-secret"
    guaranteed_endpoint_permission_override_enabled = true
    enabled = true
    client_profile_name = solacebroker_msg_vpn_client_profile.orders-profile.client_profile_name
    acl_profile_name = solacebroker_msg_vpn_acl_profile.orders-acl.acl_profile_name
}

#ACl profile for Orders
resource "solacebroker_msg_vpn_acl_profile" "orders-acl" {
    msg_vpn_name = var.msg_vpn_name
    acl_profile_name = "Orders_ACL"
    client_connect_default_action = "allow"
    publish_topic_default_action = "disallow"
    subscribe_share_name_default_action = "disallow"  
}
resource "solacebroker_msg_vpn_acl_profile_publish_topic_exception" "orders_publish" {
    msg_vpn_name                  = var.msg_vpn_name
    acl_profile_name              = solacebroker_msg_vpn_acl_profile.orders-acl.acl_profile_name
    publish_topic_exception       = "topic/orders/*"
    publish_topic_exception_syntax = "smf"
}
resource "solacebroker_msg_vpn_acl_profile_subscribe_topic_exception" "orders_subscribe" {
    msg_vpn_name                   = var.msg_vpn_name
    acl_profile_name               = solacebroker_msg_vpn_acl_profile.orders-acl.acl_profile_name
    subscribe_topic_exception      = "topic/orders/*"
    subscribe_topic_exception_syntax = "smf"
  }

#client profiles for Payments
resource "solacebroker_msg_vpn_client_profile" "payments-profile" {
    msg_vpn_name        = var.msg_vpn_name
    client_profile_name = "Payments_Profile"
    allow_guaranteed_msg_send_enabled = true
    allow_guaranteed_msg_receive_enabled = true
    allow_guaranteed_endpoint_create_enabled = true
    max_connection_count_per_client_username = 10
}

#Client Usernames for Payments
resource "solacebroker_msg_vpn_client_username" "payments-app" {
    msg_vpn_name = var.msg_vpn_name
    client_username = "Payments_App"
    password = "payments-secret"
    guaranteed_endpoint_permission_override_enabled = true
    enabled = true
    client_profile_name = solacebroker_msg_vpn_client_profile.payments-profile.client_profile_name
    acl_profile_name = solacebroker_msg_vpn_acl_profile.payments-acl.acl_profile_name
}

#ACl profile for Payments
resource "solacebroker_msg_vpn_acl_profile" "payments-acl" {
    msg_vpn_name = var.msg_vpn_name
    acl_profile_name = "Payments_ACL"
    client_connect_default_action = "allow"
    publish_topic_default_action = "disallow"
    subscribe_share_name_default_action = "disallow"
}
resource "solacebroker_msg_vpn_acl_profile_publish_topic_exception" "payments_publish" {
    msg_vpn_name                  = var.msg_vpn_name
    acl_profile_name              = solacebroker_msg_vpn_acl_profile.payments-acl.acl_profile_name
    publish_topic_exception       = "topic/payments/*"
    publish_topic_exception_syntax = "smf"
}
resource "solacebroker_msg_vpn_acl_profile_subscribe_topic_exception" "payments_subscribe" {
    msg_vpn_name                   = var.msg_vpn_name
    acl_profile_name               = solacebroker_msg_vpn_acl_profile.payments-acl.acl_profile_name
    subscribe_topic_exception      = "topic/payments/*"
    subscribe_topic_exception_syntax = "smf"
}

#client profiles for Notifications
resource "solacebroker_msg_vpn_client_profile" "notifications-profile" {
    msg_vpn_name        = var.msg_vpn_name
    client_profile_name = "Notifications_Profile"
    allow_guaranteed_msg_send_enabled = true
    allow_guaranteed_msg_receive_enabled = true
    allow_guaranteed_endpoint_create_enabled = true
    max_connection_count_per_client_username = 10
}

#Client Usernames for Notifications
resource "solacebroker_msg_vpn_client_username" "notifications-app" {
    msg_vpn_name = var.msg_vpn_name
    client_username = "Notifications_App"
    password = "notifications-secret"
    guaranteed_endpoint_permission_override_enabled = true
    enabled = true
    client_profile_name = solacebroker_msg_vpn_client_profile.notifications-profile.client_profile_name
    acl_profile_name = solacebroker_msg_vpn_acl_profile.notifications-acl.acl_profile_name
}

#ACl profile for Notifications
resource "solacebroker_msg_vpn_acl_profile" "notifications-acl" {
    msg_vpn_name = var.msg_vpn_name
    acl_profile_name = "Notifications_ACL"
    client_connect_default_action = "allow"
    publish_topic_default_action = "disallow"
    subscribe_share_name_default_action = "disallow"
}
resource "solacebroker_msg_vpn_acl_profile_publish_topic_exception" "notifications_publish" {
    msg_vpn_name                  = var.msg_vpn_name
    acl_profile_name              = solacebroker_msg_vpn_acl_profile.notifications-acl.acl_profile_name
    publish_topic_exception       = "topic/notifications/*"
    publish_topic_exception_syntax = "smf"
}
resource "solacebroker_msg_vpn_acl_profile_subscribe_topic_exception" "notifications_subscribe" {
    msg_vpn_name                   = var.msg_vpn_name
    acl_profile_name               = solacebroker_msg_vpn_acl_profile.notifications-acl.acl_profile_name
    subscribe_topic_exception      = "topic/notifications/*"
    subscribe_topic_exception_syntax = "smf"
}