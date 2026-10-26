# 🏛️ Azure DevOps Enterprise Landing Zone Delivery Pipelines

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Azure DevOps](https://img.shields.io/badge/CI%2FCD-Azure_Pipelines-0078D7.svg?logo=azuredevops)](https://dev.azure.com/)
[![Terraform](https://img.shields.io/badge/IaC-Terraform_1.5+-623CE4.svg?logo=terraform)](https://www.terraform.io/)
[![Cloud Adoption Framework](https://img.shields.io/badge/Architecture-Microsoft_CAF-0078D4.svg)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)
[![Security: OIDC](https://img.shields.io/badge/Security-OIDC_Workload_Federation-success.svg)](https://learn.microsoft.com/)

**End-to-End Enterprise Landing Zone Delivery Engine • Workload Identity OIDC Federation • Multi-Stage Environments • Architectural Approval Gates**

[Overview](#-executive-overview) • [Pipeline Stages](#-multi-stage-pipeline-architecture) • [CAF Architecture](#-caf-landing-zone-structure) • [Setup](#-oidc-service-connection-setup)

</div>

---

## 🎯 Executive Overview

Deploying Microsoft Cloud Adoption Framework (CAF) Enterprise Landing Zones requires rigorous, audited governance. **Azure DevOps Enterprise Landing Zone** is an automated CI/CD framework engineered by **Gunjan Kumar Gaurav** that replaces brittle personal service principal credentials with **Workload Identity OIDC Federation**.

```
[ Azure DevOps Git Repository ]
                |
                v  (Trigger on PR / Merge)
[ Stage 1: Validation & Security Gate ]
• Checkov static IaC scanning
• TFLint syntax and module inspection
• Terraform fmt compliance
                |
                v
[ Stage 2: Speculative Execution & Plan ]
• Passwordless OIDC authentication via Azure DevOps Service Connection
• Remote State Locking in Azure Blob Storage
• Infracost cost estimation & plan artifact upload
                |
                v
[ Stage 3: Non-Production Deployment ]
• Automated deploy to Dev/UAT subscriptions
                |
                v  (Manual Approval Gate by Senior Cloud Architect)
[ Stage 4: Production Landing Zone Deployment ]
• Enterprise Management Group Hierarchy
• Hub VNet, Azure Firewall, Bastion & Central Private DNS
• Azure Policy Guardrail assignments
```

---

## 🚀 Key Pipeline Capabilities

* **Zero-Secret OIDC Service Connection:** Uses Azure AD Federated Identity Credentials eliminating static client secrets and expired password outages.
* **Granular Architectural Approval Gates:** Enforces human review by designated Cloud Platform Architects before Production environment execution.
* **Automated Rollback-Ready Plan Artifacts:** Generates immutable `tfplan.binary` files in Stage 2 and consumes the identical compiled binary in Production.
* **Strict CAF Hierarchy:** Provisions Management Groups (`Platform`, `Landing-Zones`, `Sandboxes`) and central hub networking.

---

## 📁 Repository Structure

```
azure-devops-enterprise-landing-zone/
├── .azure-devops/
│   ├── pipelines/
│   │   └── azure-pipelines-landingzone.yml   # Multi-stage enterprise pipeline
│   └── templates/                            # Reusable step templates
├── terraform/
│   ├── management_groups.tf                  # CAF Root & Child hierarchy
│   ├── hub_network.tf                        # Azure Firewall, Bastion & Subnets
│   ├── variables.tf
│   └── outputs.tf
└── README.md
```

---

## 👤 Architect & Author

**Gunjan Kumar Gaurav**  
*Senior Cloud Architect & DevSecOps Consultant*  
[LinkedIn](https://www.linkedin.com/in/gunjan-gaurav) • [GitHub](https://github.com/gunjankumargaurav7350) • Email: `gunjankumargaurav7@gmail.com`
