terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "4.18.0"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Queue depth usage monitor
resource "datadog_monitor" "queue_depth" {
  name    = "Solace Queue Depth Alert"
  type    = "query alert"
  query   = "avg(last_5m):avg:solace.queue.msg_spool_usage{queue:orders} > 80"
  message = "⚠️ Queue depth exceeded 80% on Solace Orders queue. @slack-alerts"
  tags    = ["solace", "queue", "orders"]
}

# VPN up/down status monitor
resource "datadog_monitor" "vpn_status" {
  name    = "Solace VPN Status"
  type    = "service check"
  query   = "\"solace.vpn.up\".over(\"*\").by(\"vpn\").last(2).count_by_status()"
  message = "🚨 Solace VPN is down! @slack-alerts"
  tags    = ["solace", "vpn"]
}

# Client connection count monitor
resource "datadog_monitor" "client_connections" {
  name    = "Solace Client Connections"
  type    = "query alert"
  query   = "avg(last_5m):avg:solace.client.connections{vpn:dev_vpn} > 100"
  message = "⚠️ Client connections exceeded 100 on dev_vpn. @slack-alerts"
  tags    = ["solace", "clients"]
}

resource "datadog_dashboard" "solace_dashboard" {
  title       = "Solace Monitoring Dashboard"
  description = "Overview of Solace queues, VPN status, and client connections"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      title = "Queue Depth Usage"
      request {
        q = "avg:solace.queue.msg_spool_usage{*}"
      }
    }
  }

  widget {
    query_value_definition {
      title = "VPN Status"
      request {
        q = "avg:solace.vpn.up{*}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Client Connections"
      request {
        q = "avg:solace.client.connections{*}"
      }
    }
  }
}
