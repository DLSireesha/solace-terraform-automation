# Solace Terraform Automation

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge\&logo=terraform\&logoColor=white)
![Solace](https://img.shields.io/badge/Solace-PubSub%2B-00AEEF?style=for-the-badge)
![Datadog](https://img.shields.io/badge/Datadog-Monitoring-632CA6?style=for-the-badge\&logo=datadog\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=for-the-badge\&logo=github-actions\&logoColor=white)
![Git](https://img.shields.io/badge/Git-Version_Control-F05032?style=for-the-badge\&logo=git\&logoColor=white)

## 📌 Overview

**Solace Terraform Automation** is an Infrastructure-as-Code (IaC) project that automates the provisioning and management of **Solace PubSub+ messaging resources** using **Terraform**.

The project provisions Solace messaging infrastructure, configures application-level access control using **Client Profiles, Client Usernames, and ACL Profiles**, integrates **Datadog** for monitoring and alerting, and uses **GitHub Actions** for CI/CD automation.

The goal is to replace manual Solace configuration with a **repeatable, version-controlled, secure, and automated infrastructure deployment process**.

---

## 🎯 Project Objectives

The project demonstrates how Terraform can be used to:
* Provision Solace messaging resources as Infrastructure as Code
* Provision a Solace Cloud service
* Create queues and Dead Message Queues (DMQs)
* Configure topic subscriptions
* Configure Solace Client Profiles
* Create application-specific Client Usernames
* Configure ACL Profiles
* Control publish and subscribe permissions
* Create Datadog monitors
* Create a Datadog monitoring dashboard
* Automate Terraform workflows using GitHub Actions
* Manage infrastructure configuration through Git

---

# 🏗️ Architecture

```text
                         ┌──────────────────────┐
                         │      Developer       │
                         │                      │
                         │ Terraform / Git      │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │   GitHub Repository  │
                         │                      │
                         │ Terraform Code      │
                         └──────────┬───────────┘
                                    │
                              Push / Pull Request
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │    GitHub Actions    │
                         │                      │
                         │ Terraform Init       │
                         │ Terraform Validate   │
                         │ Terraform Plan       │
                         │ Terraform Apply      │
                         └───────┬───────┬──────┘
                                 │       │
                    ┌────────────┘       └─────────────┐
                    ▼                                  ▼
          ┌──────────────────────┐           ┌──────────────────────┐
          │     Solace PubSub+   │           │       Datadog        │
          │                      │           │                      │
          │ Queues               │           │ Monitors             │
          │ DMQs                 │           │ Alerts               │
          │ Topic Subscriptions  │           │ Dashboard            │
          │ Client Profiles      │           │                      │
          │ Client Usernames     │           │                      │
          │ ACL Profiles         │           │                      │
          └──────────────────────┘           └──────────────────────┘
                    ▲
                    │
          ┌──────────────────────┐
          │     Solace Service   │
          └──────────────────────┘
```

---

# 🛠️ Technologies Used

| Technology                    | Purpose                           |
| ----------------------------- | --------------------------------- |
| **Terraform**                 | Infrastructure as Code            |
| **Solace PubSub+**            | Event messaging platform          |
| **Solace Terraform Provider** | Provision Solace broker resources |
| **Solace Cloud Provider**     | Provision Solace Cloud services   |
| **Datadog**                   | Monitoring and alerting           |
| **GitHub Actions**            | CI/CD automation                  |
| **Git/GitHub**                | Version control                   |

---

# 📂 Project Structure

```text
solace-terraform-automation/
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── cloud-service/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── broker-service/
│   ├── main.tf
│   ├── profiles.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── monitoring/
│   ├── main.tf
|   ├── ddagent-install.log
│   └── variables.tf
│
├── .gitignore
└── README.md
```

> **Note:** Terraform state files (`terraform.tfstate`), `.terraform/` directories, and sensitive `.tfvars` files should not be committed to the repository.

---

# ☁️ 1. Solace Cloud Service

The `cloud-service` directory contains Terraform configuration for provisioning a **Solace Cloud service**.

The configured service is:

```text
Solace-Devops-Pubsub
```

The project uses:

```text
SolaceProducts/solacecloud
```

Terraform provider.

Provider version:

```text
~> 0.2.0
```

Authentication is handled through an API token rather than storing credentials directly in the Terraform configuration.


# 🔹 2. Solace Broker Automation

The `broker-service` directory contains Terraform configuration for provisioning and managing resources on a **Solace PubSub+ Event Broker**.

The project uses the:

```text
SolaceProducts/solacebroker
```

Terraform provider.

Provider version:

```text
1.3.0
```

---

## 📦 Messaging Resources

The Terraform configuration creates application-specific queues, Dead Message Queues, and topic subscriptions.

### Orders

```text
Queue_Orders
Queue_Orders.DMQ
```

Topic subscriptions:

```text
topic/orders/created
topic/orders/updated
```

### Payments

```text
Queue_Payments
Queue_Payments.DMQ
```

Topic subscription:

```text
topic/payments/processed
```

### Notifications

```text
Queue_Notifications
Queue_Notifications.DMQ
```

Topic subscriptions:

```text
topic/notifications/email
topic/notifications/sms
```

---

## ⚙️ Queue Configuration

The queues are configured with messaging properties including:

* Exclusive access
* Message spool limits
* Dead Message Queues
* Ingress enabled
* Egress enabled
* Maximum message size
* Message redelivery
* Maximum redelivery count

These configurations are managed through Terraform, allowing the messaging infrastructure to be reproduced consistently.

---

# 🔐 3. Client Profiles

The project also automates **Solace Client Profiles** for application clients.

A Client Profile controls client connection and messaging capabilities.

Three application-specific Client Profiles are created:

| Application   | Client Profile          |
| ------------- | ----------------------- |
| Orders        | `Orders_Profile`        |
| Payments      | `Payments_Profile`      |
| Notifications | `Notifications_Profile` |

The profiles configure capabilities such as:

```text
Guaranteed Message Send
Guaranteed Message Receive
Guaranteed Endpoint Creation
```

The maximum number of connections per client username is configured as:

```text
10
```

---

# 👤 4. Client Usernames

Each application is assigned a dedicated Solace Client Username.

| Application   | Client Username     | Client Profile          | ACL Profile         |
| ------------- | ------------------- | ----------------------- | ------------------- |
| Orders        | `Orders_App`        | `Orders_Profile`        | `Orders_ACL`        |
| Payments      | `Payments_App`      | `Payments_Profile`      | `Payments_ACL`      |
| Notifications | `Notifications_App` | `Notifications_Profile` | `Notifications_ACL` |

The Client Username associates the application identity with:

1. A **Client Profile**
2. An **ACL Profile**

This provides a clear separation between client capabilities and authorization.

---

# 🛡️ 5. ACL Profiles

ACLs (Access Control Lists) are used to control which messaging topics an application can publish to or subscribe to.

The project creates separate ACL Profiles for each application.

| Application   | ACL Profile         | Topic Namespace         |
| ------------- | ------------------- | ----------------------- |
| Orders        | `Orders_ACL`        | `topic/orders/*`        |
| Payments      | `Payments_ACL`      | `topic/payments/*`      |
| Notifications | `Notifications_ACL` | `topic/notifications/*` |

---

## 📤 Publish Permissions

Publishing is restricted by default:

```text
publish_topic_default_action = "disallow"
```

Each application is then explicitly allowed to publish to its own topic namespace.

| Application   | Publish Permission      |
| ------------- | ----------------------- |
| Orders        | `topic/orders/*`        |
| Payments      | `topic/payments/*`      |
| Notifications | `topic/notifications/*` |

For example:

```text
Orders Application
        │
        └── Publish → topic/orders/*
```

The Orders application is not granted publish access to unrelated application topics.

---

## 📥 Subscribe Permissions

Subscription access follows the same application-specific model.

The default subscription action is restricted:

```text
subscribe_share_name_default_action = "disallow"
```

Each application is explicitly allowed to subscribe to its own topic namespace.

| Application   | Subscribe Permission    |
| ------------- | ----------------------- |
| Orders        | `topic/orders/*`        |
| Payments      | `topic/payments/*`      |
| Notifications | `topic/notifications/*` |

---

# 🔄 Application Access Flow

### Orders Application

```text
Orders Application
        │
        ▼
Orders_App
        │
        ▼
Orders_Profile
        │
        ▼
Orders_ACL
        │
        ├── Publish → topic/orders/*
        │
        └── Subscribe → topic/orders/*
```

### Payments Application

```text
Payments Application
        │
        ▼
Payments_App
        │
        ▼
Payments_Profile
        │
        ▼
Payments_ACL
        │
        ├── Publish → topic/payments/*
        │
        └── Subscribe → topic/payments/*
```

### Notifications Application

```text
Notifications Application
        │
        ▼
Notifications_App
        │
        ▼
Notifications_Profile
        │
        ▼
Notifications_ACL
        │
        ├── Publish → topic/notifications/*
        │
        └── Subscribe → topic/notifications/*
```

---

# 🔒 6. Access Control Model

The project implements a layered access-control model:

```text
                    Application
                         │
                         ▼
                  Client Username
                         │
                 ┌───────┴────────┐
                 ▼                ▼
          Client Profile      ACL Profile
                 │                │
                 ▼                ▼
       Connection & Client    Publish /
          Capabilities        Subscribe
                              Permissions
```

### Client Profile

Controls **what the client is capable of doing**.

Examples:

* Guaranteed messaging
* Endpoint creation
* Maximum connections

### Client Username

Represents the application's identity and associates it with the required profiles.

### ACL Profile

Controls **where the client is allowed to communicate**.

Examples:

* Publish permissions
* Subscribe permissions
* Topic-level access

---

# 🎯 7. Least-Privilege Access

The ACL configuration follows the **principle of least privilege**.

Instead of giving every application access to all topics, each application is restricted to its own topic namespace.

```text
❌ Orders        → topic/payments/*
❌ Orders        → topic/notifications/*

❌ Payments      → topic/orders/*
❌ Payments      → topic/notifications/*

❌ Notifications → topic/orders/*
❌ Notifications → topic/payments/*
```

Allowed access:

```text
✅ Orders        → topic/orders/*
✅ Payments      → topic/payments/*
✅ Notifications → topic/notifications/*
```

This reduces the risk of unauthorized publishing or consuming of messages between applications.

---

---

# 📊 8. Datadog Monitoring

The `monitoring` directory contains Terraform configuration for monitoring the Solace environment using **Datadog**.

The project uses:

```text
DataDog/datadog
```

Terraform provider.

Provider version:

```text
4.18.0
```

---

## 📈 Monitoring Configuration

The project provides monitoring for important Solace service conditions.

### Queue Depth Monitoring

A Datadog monitor tracks Solace queue message spool usage.

Configured alert threshold:

```text
80%
```

This helps identify:

* Queue buildup
* Slow consumers
* Downstream processing issues
* Potential message-processing bottlenecks

---

### VPN Status Monitoring

A Datadog service check monitors the availability of the Solace VPN.

An alert is triggered when the VPN becomes unavailable.

This helps detect messaging infrastructure availability issues.

---

### Client Connection Monitoring

The project monitors the number of client connections to the Solace VPN.

Configured alert threshold:

```text
100 connections
```

This can help identify:

* Unexpected connection growth
* Application connection issues
* Potential connection leaks
* Abnormal client activity

---

# 📊 9. Datadog Dashboard

Terraform is also used to create a Datadog dashboard:

```text
Solace Monitoring Dashboard
```

The dashboard provides visibility into:

* Queue depth
* VPN status
* Client connections

This provides a centralized view of the Solace environment and its operational health.

---

# 🔄 10. CI/CD with GitHub Actions

The project uses **GitHub Actions** to automate Terraform operations.

The workflow is located at:

```text
.github/workflows/terraform.yml
```

---

## 🔀 Pull Request Workflow

For pull requests targeting the `main` branch, Terraform performs validation and planning.

```text
Pull Request
     │
     ▼
Terraform Init
     │
     ▼
Terraform Validate
     │
     ▼
Terraform Plan
```

This allows infrastructure changes to be reviewed before deployment.

---

## 🚀 Main Branch Deployment

When changes are pushed to the `main` branch, the workflow executes the Terraform deployment.

```text
Push to main
     │
     ▼
Terraform Init
     │
     ▼
Terraform Validate
     │
     ▼
Terraform Plan
     │
     ▼
Terraform Apply
```

This provides an automated Infrastructure-as-Code deployment pipeline.

---

# 🔐 11. Secrets Management

Sensitive credentials should never be hard-coded in Terraform configuration or committed to Git.

The GitHub Actions workflow uses GitHub Secrets for authentication.

### Solace Secrets

```text
SOLACEBROKER_USERNAME
SOLACEBROKER_PASSWORD
SOLACEBROKER_URL
MSG_VPN_NAME
```

### Datadog Secrets

```text
DATADOG_API_KEY
DATADOG_APP_KEY
```

These secrets should be configured in:

```text
GitHub Repository
      ↓
Settings
      ↓
Secrets and variables
      ↓
Actions
```

---

## ⚠️ Client Passwords

Client Username passwords should also be handled securely.

Avoid:

```hcl
password = "my-password"
```

Instead, use a sensitive Terraform variable:

```hcl
variable "orders_password" {
  description = "Password for Orders application"
  type        = string
  sensitive   = true
}
```

Then reference it:

```hcl
password = var.orders_password
```

---

# 💻 12. Local Setup

## Prerequisites

Install the following:

* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [Git](https://git-scm.com/downloads)
* Solace Cloud account
* Datadog account
* Datadog API key
* Datadog Application key

---

# 📥 Clone the Repository

```bash
git clone https://github.com/DLSireesha/solace-terraform-automation.git

cd solace-terraform-automation
```

# ☁️ 13. Deploy Solace Cloud Service

Navigate to:

```bash
cd ../cloud-service
```

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

---

# ▶️ 14. Deploy Broker Resources

Navigate to the broker configuration:

```bash
cd broker-service
```

Initialize Terraform:

```bash
terraform init
```

Format the Terraform configuration:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

Terraform will provision the configured Solace messaging resources, client profiles, client usernames, ACL profiles, and topic permissions.

---

---

# 📡 15. Deploy Datadog Monitoring

Navigate to:

```bash
cd ../monitoring
```

Initialize Terraform:

```bash
terraform init
```

Format:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

This provisions the configured Datadog monitors and dashboard.

---

# 🧹 16. Destroy Resources

Terraform can be used to remove resources when they are no longer required.

```bash
terraform destroy
```

> ⚠️ **Warning:** `terraform destroy` permanently removes resources managed by the Terraform configuration. Always review the Terraform plan carefully before confirming the operation.

---

# 🔄 17. Terraform Workflow

The general Terraform workflow used in this project is:

```text
Write Terraform Configuration
          │
          ▼
      terraform fmt
          │
          ▼
      terraform init
          │
          ▼
    terraform validate
          │
          ▼
      terraform plan
          │
          ▼
      terraform apply
          │
          ▼
 Infrastructure Created
```

---

# 🌟 18. Key Benefits

### Automation

Solace resources can be provisioned automatically instead of manually configuring each resource.

### Repeatability

The same Terraform configuration can be used to reproduce infrastructure consistently.

### Version Control

Infrastructure changes are tracked in Git and can be reviewed through pull requests.

### Security

Client access is controlled using Client Profiles, Client Usernames, and ACL Profiles following the principle of least privilege.

### Monitoring as Code

Datadog monitors and dashboards are defined and managed through Terraform.

### CI/CD

GitHub Actions automates Terraform validation, planning, and deployment.

### Reduced Configuration Drift

Infrastructure configuration is maintained as code, reducing differences between the desired and actual infrastructure state.

---


---

# 📚 19. References

* [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
* [Solace Terraform Provider](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest)
* [Solace Cloud Terraform Provider](https://registry.terraform.io/providers/SolaceProducts/solacecloud/latest)
* [Datadog Terraform Provider](https://registry.terraform.io/providers/DataDog/datadog/latest)
* [GitHub Actions Documentation](https://docs.github.com/en/actions)
* [Solace Documentation](https://docs.solace.com/)

---

# 👩‍💻 Author

**D.L. Sireesha**

GitHub: [DLSireesha](https://github.com/DLSireesha)

---

# ⭐ Project Repository

[Solace Terraform Automation](https://github.com/DLSireesha/solace-terraform-automation)

If you find this project useful, consider giving the repository a ⭐ on GitHub.
