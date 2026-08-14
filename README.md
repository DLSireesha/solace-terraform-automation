# Solace Terraform Automation

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge\&logo=terraform\&logoColor=white)
![Solace](https://img.shields.io/badge/Solace-PubSub%2B-00AEEF?style=for-the-badge)
![Datadog](https://img.shields.io/badge/Datadog-Monitoring-632CA6?style=for-the-badge\&logo=datadog\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=for-the-badge\&logo=github-actions\&logoColor=white)
![Git](https://img.shields.io/badge/Git-Version_Control-F05032?style=for-the-badge\&logo=git\&logoColor=white)

## 📌 Overview

**Solace Terraform Automation** is an Infrastructure-as-Code (IaC) project that automates the provisioning and management of **Solace PubSub+ messaging resources** using **Terraform**.

The project also integrates **Datadog** for monitoring and alerting and uses **GitHub Actions** to automate Terraform validation, planning, and deployment.

The objective is to replace manual Solace resource configuration with a **repeatable, version-controlled, and automated infrastructure deployment process**.

---

## 🏗️ Architecture

```text
                         ┌─────────────────────┐
                         │      Developer      │
                         │                     │
                         │ Terraform / Git     │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │   GitHub Repository │
                         │                     │
                         │ Terraform Code     │
                         └──────────┬──────────┘
                                    │
                              Push / PR
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │   GitHub Actions    │
                         │                     │
                         │ Terraform Init      │
                         │ Terraform Validate  │
                         │ Terraform Plan      │
                         │ Terraform Apply     │
                         └───────┬───────┬─────┘
                                 │       │
                    ┌────────────┘       └─────────────┐
                    ▼                                  ▼
          ┌─────────────────────┐            ┌─────────────────────┐
          │    Solace PubSub+   │            │       Datadog       │
          │                     │            │                     │
          │ Queues              │            │ Monitors            │
          │ DMQs                │            │ Alerts              │
          │ Topic Subscriptions │            │ Dashboard           │
          │ VPN Resources       │            │                     │
          └─────────────────────┘            └─────────────────────┘
                    ▲
                    │
          ┌─────────────────────┐
          │    Solace Cloud     │
          │      Service        │
          └─────────────────────┘
```

---

## 🚀 What This Project Does

This project automates the following infrastructure and monitoring tasks:

* Provisioning **Solace PubSub+ broker resources**
* Creating **queues**
* Creating **Dead Message Queues (DMQs)**
* Creating **topic subscriptions**
* Configuring queue properties
* Provisioning a **Solace Cloud service**
* Creating **Datadog monitors**
* Creating a **Datadog monitoring dashboard**
* Automating Terraform operations using **GitHub Actions**
* Managing infrastructure configuration through Git

---

## 🛠️ Technologies Used

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
├── broker-service/
│   ├── main.tf
│   ├── profiles.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── cloud-service/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── monitoring/
│   ├── main.tf
│   ├── variables.tf
│   └── ddagent-install.log
│
└── README.md
```

---

# 🔹 1. Broker Service

The `broker-service` directory contains Terraform configuration for provisioning and managing resources on a **Solace PubSub+ Event Broker**.

The project uses the **Solace Broker Terraform Provider**.

### Provider

```hcl
SolaceProducts/solacebroker
```

Provider version:

```text
1.3.0
```

---

## 📦 Solace Resources

The Terraform configuration creates multiple messaging resources.

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

The queues are configured with properties such as:

* Exclusive access
* Message spool limits
* Dead Message Queues
* Ingress enabled
* Egress enabled
* Maximum message size
* Message TTL
* Message redelivery
* Maximum redelivery count

These configurations are maintained as Terraform code, making them reproducible and version controlled.

---

# 🔹 2. Solace Cloud Service

The `cloud-service` directory contains Terraform configuration for provisioning a **Solace Cloud service**.

The configured service is:

```text
Solace-Devops-Pubsub
```

The project uses the Solace Cloud Terraform provider:

```hcl
SolaceProducts/solacecloud
```

Provider version:

```text
~> 0.2.0
```

Authentication is handled through an API token rather than storing credentials directly in the Terraform configuration.

---

# 🔹 3. Datadog Monitoring

The `monitoring` directory contains Terraform configuration for monitoring the Solace environment using **Datadog**.

The project uses:

```hcl
DataDog/datadog
```

Provider version:

```text
4.18.0
```

---

## 📊 Monitoring

The project configures monitoring for important Solace metrics and service conditions.

### Queue Depth Monitoring

A Datadog monitor tracks Solace queue message spool usage.

The configured alert threshold is:

```text
80%
```

This helps identify queue buildup and potential consumer or downstream processing issues.

---

### VPN Status Monitoring

A Datadog service check monitors the availability of the Solace VPN.

An alert is triggered when the VPN becomes unavailable.

---

### Client Connection Monitoring

The project monitors the number of client connections to the Solace VPN.

The configured alert threshold is:

```text
100 connections
```

This helps identify unexpected increases in client connections.

---

# 📈 Datadog Dashboard

Terraform is also used to create a Datadog dashboard:

```text
Solace Monitoring Dashboard
```

The dashboard provides visibility into:

* Queue depth
* VPN status
* Client connections

This provides a centralized view of the Solace environment.

---

# 🔄 CI/CD with GitHub Actions

The project uses **GitHub Actions** to automate Terraform operations.

The workflow is located at:

```text
.github/workflows/terraform.yml
```

### Workflow

```text
Developer
    │
    │ Git Commit / Pull Request
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Terraform Init
    │
    ├── Terraform Validate
    │
    ├── Terraform Plan
    │
    └── Terraform Apply
    │
    ├───────────────────┐
    ▼                   ▼
Solace Resources     Datadog
                     Monitoring
```

---

## 🔀 Pull Request Workflow

For pull requests to the `main` branch, the workflow performs Terraform validation and planning.

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

This helps identify infrastructure changes before they are deployed.

---

## 🚀 Main Branch Deployment

When changes are pushed to the `main` branch, the workflow performs the Terraform deployment.

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

# 🔐 Secrets Management

Sensitive credentials should not be stored directly in Terraform files or committed to Git.

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

Secrets should be configured in:

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

# 💻 Local Setup

## Prerequisites

Install the following tools:

* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [Git](https://git-scm.com/downloads)
* Solace PubSub+ Event Broker access
* Solace management credentials
* Solace Cloud account (if using cloud-service)
* Datadog account
* Datadog API key
* Datadog Application key

---

# 📥 Clone the Repository

```bash
git clone https://github.com/DLSireesha/solace-terraform-automation.git

cd solace-terraform-automation
```

---

# ▶️ Deploy Broker Resources

Navigate to the broker configuration:

```bash
cd broker-service
```

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Format the Terraform files:

```bash
terraform fmt
```

Create an execution plan:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

---

# ☁️ Deploy Solace Cloud Service

Navigate to:

```bash
cd ../cloud-service
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Format:

```bash
terraform fmt
```

Create the execution plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

---

# 📡 Deploy Datadog Monitoring

Navigate to:

```bash
cd ../monitoring
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Format:

```bash
terraform fmt
```

Create the execution plan:

```bash
terraform plan
```

Apply the monitoring configuration:

```bash
terraform apply
```

This provisions the configured Datadog monitors and dashboard.

---

# 🧹 Destroy Resources

Terraform can also be used to remove resources that are no longer required.

```bash
terraform destroy
```

> ⚠️ **Warning:** `terraform destroy` permanently removes resources managed by the Terraform configuration. Always review the Terraform plan before confirming the operation.

---

# 🔄 Terraform Workflow

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

# 🎯 Key DevOps Concepts Demonstrated

This project demonstrates practical DevOps and Infrastructure-as-Code concepts:

* Infrastructure as Code (IaC)
* Terraform
* Terraform Providers
* Terraform Resources
* Terraform Variables
* Terraform Outputs
* Terraform State
* Provider Version Management
* Infrastructure Provisioning
* Infrastructure Monitoring as Code
* CI/CD
* GitHub Actions
* Git-based Infrastructure Management
* Secrets Management
* Automated Validation
* Automated Deployment
* Event-Driven Architecture
* Messaging Infrastructure
* Observability
* Monitoring and Alerting

---

# 🌟 Benefits

## Automation

Solace resources can be provisioned automatically instead of manually configuring each resource.

## Repeatability

The same Terraform configuration can be used to reproduce infrastructure consistently.

## Version Control

Infrastructure changes are tracked in Git and can be reviewed through pull requests.

## Monitoring as Code

Datadog monitors and dashboards are defined and managed through Terraform.

## CI/CD

GitHub Actions automates Terraform validation, planning, and deployment.

## Reduced Configuration Drift

Infrastructure configuration is maintained as code, reducing differences between the desired and actual infrastructure state.

---

# 🔮 Future Enhancements

The project can be extended with the following improvements:

* [ ] Create reusable Terraform modules
* [ ] Add separate `dev`, `test`, and `prod` environments
* [ ] Implement remote Terraform state
* [ ] Add Terraform formatting validation to CI/CD
* [ ] Add Terraform security scanning
* [ ] Add automated Terraform plan comments to Pull Requests
* [ ] Add manual approval before production deployment
* [ ] Add additional Solace metrics to Datadog
* [ ] Add Datadog log monitoring
* [ ] Integrate Dynatrace monitoring
* [ ] Integrate Azure infrastructure
* [ ] Add environment-specific `.tfvars` files
* [ ] Implement centralized secrets management
* [ ] Add automated infrastructure testing

---

# 📚 References

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

# ⭐ Project

If you find this project useful, consider giving the repository a ⭐ on GitHub.

**Repository:** [solace-terraform-automation](https://github.com/DLSireesha/solace-terraform-automation)
