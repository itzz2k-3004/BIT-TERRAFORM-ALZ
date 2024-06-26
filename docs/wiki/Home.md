<!-- markdownlint-disable first-line-heading first-line-h1 -->
Welcome to the Azure landing zones Terraform accelerator!

The [Azure landing zones Terraform module][alz_tf_registry] provides an opinionated approach for deploying and managing the core platform capabilities of [Azure landing zones architecture][alz_architecture] using Terraform, with a focus on the central resource hierarchy:

This accelerator provides an opinionated approach for configuring and securing that module in a continuous delivery pipeline. It has end to end automation for bootstrapping the module and it also provides guidance on branching strategies.

## Supported Version Control Systems (VCS)

The accelerator supports both Azure DevOps and GitHub as a VCS. We are only able to support the hosted versions of these services as we use the Terraform providers to configure the environment, which do not support self-hosted versions of these services.

If you are using self-hosted versions of these services, you can still use the accelerator to produce the landing zone code by using the `-c "local"` flag option, but you will need to configure the VCS manually or with your own automation.

## Accelerator features

The accelerator bootstraps a continuous delivery environment for you. It supports both the Azure DevOps and GitHub version control system (VCS). It uses the PowerShell module [ALZ](https://www.powershellgallery.com/packages/ALZ) to gather required user input and apply a Terraform module to configure the bootstrap environment.

The accelerator follows a 3 phase approach:

1. Pre-requisites: Instructions to configure credentials and subscriptions.
2. Bootstrap: Run the PowerShell script to generate the continuous delivery environment.
3. Run: Update the module (if needed) to suit the needs of your organisation and deploy via continuous delivery.

![Azure landing zone accelerator process][alz_accelerator_overview]

The components of the environment are similar, but differ depending on your choice of VCS:

![Components][components]

### GitHub

- Azure:
  - Resource Group for State
  - Storage Account and Container for State
  - Resource Group for Identity
  - User Assigned Managed Identities (UAMI) with Federated Credentials for Plan and Apply
  - Permissions for the UAMI on state storage container, subscriptions and management groups
  - [Optional] Container Instances hosting GitHub Runners
  - [Optional] Virtual network, subnets, private DNS zone and private endpoint.

- GitHub
  - Repository for the Module
  - Repository for the Action Templates
  - Starter Terraform module with tfvars
  - Branch policy
  - Action for Continuous Integration
  - Action for Continuous Delivery
  - Environment for Plan
  - Environment for Apply
  - Action Variables for Backend and Plan / Apply
  - Team and Members for Apply Approval
  - Customised OIDC Token Subject for governed Actions
  - [Optional] Runner Group

### Azure DevOps

- Azure:
  - Resource Group for State
  - Storage Account and Container for State
  - Resource Group for Identity
  - User Assigned Managed Identities (UAMI) with Federated Credentials for Plan and Apply
  - Permissions for the UAMI on state storage container, subscriptions and management groups
  - [Optional] Container Instances hosting Azure DevOps Agents
  - [Optional] Virtual network, subnets, private DNS zone and private endpoint.

- Azure DevOps
  - Project (can be supplied or created)
  - Repository for the Module
  - Repository for the Pipeline Templates
  - Starter Terraform module with tfvars
  - Branch policy
  - Pipeline for Continuous Integration
  - Pipeline for Continuous Delivery
  - Environment for Plan
  - Environment for Apply
  - Variable Group for Backend
  - Service Connections with Workload identity federation for Plan and Apply
  - Service Connection Approvals, Template Validation and Concurrency Control
  - Group and Members for Apply Approval
  - [Optional] Agent Pool

### Local File System

This outputs the ALZ module files to the file system, so you can apply them manually or with your own VCS / automation.

- Azure:
  - Resource Group for State
  - Storage Account and Container for State
  - Resource Group for Identity
  - User Assigned Managed Identities (UAMI) for Plan and Apply
  - Permissions for the UAMI on state storage container, subscriptions and management groups

- Local File System
  - Starter Terraform module with tfvars

## Next steps

Check out the [User Guide](User-Guide).

## Terraform landing zones

The following diagram and links detail the Azure landing zone, but you can learn a lot more about the Azure landing zones enterprise scale module [here](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki).

![Azure landing zone conceptual architecture][alz_tf_overview]

 [//]: # (*****************************)
 [//]: # (INSERT IMAGE REFERENCES BELOW)
 [//]: # (*****************************)

[alz_accelerator_overview]: media/alz-terraform-acclerator.png "A process flow showing the areas covered by the Azure landing zones Terraform accelerator."
[components]: media/components.png "The components deployed by the accelerator."

[alz_tf_overview]: media/alz-tf-module-overview.png "A conceptual architecture diagram highlighting the design areas covered by the Azure landing zones Terraform module."

 [//]: # (************************)
 [//]: # (INSERT LINK LABELS BELOW)
 [//]: # (************************)

[alz_tf_registry]:  https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest "Terraform Registry: Azure landing zones Terraform module"
[alz_architecture]: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone#azure-landing-zone-conceptual-architecture
