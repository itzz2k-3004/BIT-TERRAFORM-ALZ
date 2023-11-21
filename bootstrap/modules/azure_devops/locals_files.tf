locals {
  agent_pool_configuration_plan  = local.is_authentication_scheme_managed_identity ? "name: ${var.environments[local.plan_key].agent_pool_name}" : "vmImage: ubuntu-latest"
  agent_pool_configuration_apply = local.is_authentication_scheme_managed_identity ? "name: ${var.environments[local.apply_key].agent_pool_name}" : "vmImage: ubuntu-latest"
  service_connection_plan_name   = var.environments[local.plan_key].service_connection_name
  service_connection_apply_name  = var.environments[local.apply_key].service_connection_name
  environment_name_plan          = var.environments[local.plan_key].environment_name
  environment_name_apply         = var.environments[local.apply_key].environment_name

  cicd_file = { for key, value in var.repository_files : key =>
    {
      content = templatefile(value.path, {
        agent_pool_configuration_plan  = local.agent_pool_configuration_plan
        agent_pool_configuration_apply = local.agent_pool_configuration_apply
        service_connection_name_plan   = local.service_connection_plan_name
        service_connection_name_apply  = local.service_connection_apply_name
        environment_name_plan          = local.environment_name_plan
        environment_name_apply         = local.environment_name_apply
        variable_group_name            = var.variable_group_name
      })
    } if value.flag == "pipeline"
  }
  cicd_template_files = { for key, value in var.repository_files : key =>
    {
      content = templatefile(value.path, {
        service_connection_name_plan  = local.service_connection_plan_name
        service_connection_name_apply = local.service_connection_apply_name
      })
    } if value.flag == "pipeline_template"
  }
  module_files = { for key, value in var.repository_files : key =>
    {
      content = replace((file(value.path)), "# backend \"azurerm\" {}", "backend \"azurerm\" {}")
    } if value.flag == "module" || value.flag == "additional"
  }
  repository_files = merge(local.cicd_file, local.module_files, var.use_template_repository ? {} : local.cicd_template_files)
}
