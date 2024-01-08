variable "starter_module" {
  description = "The starter module to use for the deployment. (e.g. 'basic')|1"
  type        = string
  default     = "basic"
}

variable "version_control_system_access_token" {
  description = "The personal access token for the version control system to use for the deployment|2"
  type        = string
  sensitive   = true
}

variable "version_control_system_organization" {
  description = "Enter the name of your Azure DevOps organization. This is the section of the url after `dev.azure.com` or before `.visualstudio.com`. E.g. for `https://dev.azure.com/my-org` you would enter `my-org`|3"
  type        = string
}

variable "version_control_system_use_separate_repository_for_templates" {
  description = "Controls whether to use a separate repository to store pipeline templates. This is an extra layer of security to ensure that the azure credentials can only be leveraged for the specified workload|4"
  type        = bool
  default     = true
}

variable "azure_location" {
  description = "Azure Deployment location for the landing zone management resources|5|azure_location"
  type        = string
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID for the landing zone management resources. Leave empty to use the az login subscription|6|azure_subscription_id"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Used to build up the default resource names (e.g. rg-<service_name>-mgmt-uksouth-001)|7|azure_name_section"
  type        = string
  default     = "alz"
}

variable "environment_name" {
  description = "Used to build up the default resource names (e.g. rg-alz-<environment_name>-uksouth-001)|8|azure_name_section"
  type        = string
  default     = "mgmt"
}

variable "postfix_number" {
  description = "Used to build up the default resource names (e.g. rg-alz-mgmt-uksouth-<postfix_number>)|9|number"
  type        = number
  default     = 1
}

variable "azure_devops_use_organisation_legacy_url" {
  description = "Use the legacy Azure DevOps URL (<organisation>.visualstudio.com) instead of the new URL (dev.azure.com/<organization>). This is ignored if an fqdn is supplied for version_control_system_organization|10|bool"
  type        = bool
  default     = false
}

variable "azure_devops_create_project" {
  description = "Create the Azure DevOps project if it does not exist|11|bool"
  type        = bool
  default     = true
}

variable "azure_devops_project_name" {
  description = "The name of the Azure DevOps project to use or create for the deployment|12"
  type        = string
}

variable "azure_devops_authentication_scheme" {
  type        = string
  description = "The authentication scheme to use for the Azure DevOps Pipelines|13|auth_scheme"
  validation {
    condition     = can(regex("^(ManagedServiceIdentity|WorkloadIdentityFederation)$", var.azure_devops_authentication_scheme))
    error_message = "azure_devops_authentication_scheme must be either ManagedServiceIdentity or WorkloadIdentityFederation"
  }
  default = "WorkloadIdentityFederation"
}

variable "apply_approvers" {
  description = "Apply stage approvers to the action / pipeline, must be a list of SPNs separate by a comma (e.g. abcdef@microsoft.com,ghijklm@microsoft.com)|14"
  type        = list(string)
  default     = []
}

variable "root_management_group_display_name" {
  description = "The root management group display name|15"
  type        = string
  default     = "Tenant Root Group"
}

variable "additional_files" {
  description = "Additional files to upload to the repository. This must be specified as a comma-separated list of absolute file paths (e.g. c:\\config\\config.yaml or /home/user/config/config.yaml)|16"
  type        = list(string)
  default     = []
}

variable "agent_container_image" {
  description = "The container image to use for Azure DevOps Agents|hidden"
  type        = string
}

variable "target_subscriptions" {
  description = "The target subscriptions to apply owner permissions to|hidden_azure_subscription_ids"
  type        = list(string)
}

variable "module_folder_path" {
  description = "The folder for the starter modules|hidden"
  type        = string
}

variable "module_folder_path_relative" {
  description = "Whether the module folder path is relative to the bootstrap module|hidden"
  type        = bool
  default     = true
}

variable "pipeline_folder_path" {
  description = "The folder for the pipelines|hidden"
  type        = string
}

variable "pipeline_folder_path_relative" {
  description = "Whether the pipeline folder path is relative to the bootstrap module|hidden"
  type        = bool
  default     = true
}

variable "pipeline_files" {
  description = "The pipeline files to upload to the repository|hidden"
  type = map(object({
    pipeline_name           = string
    file_path               = string
    target_path             = string
    environment_keys        = list(string)
    service_connection_keys = list(string)
    agent_pool_keys         = list(string)
  }))
}

variable "pipeline_template_files" {
  description = "The pipeline template files to upload to the repository|hidden"
  type = map(object({
    file_path   = string
    target_path = string
  }))
}

variable "resource_names" {
  type        = map(string)
  description = "Overrides for resource names|hidden"
}
