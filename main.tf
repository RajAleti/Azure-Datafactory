resource "azurerm_data_factory" "df" {
  name                = var.df_name
  resource_group_name = local.resource_group_name
  location            = local.location

  dynamic "github_configuration" {
    for_each = try(var.settings.github_configuration, null) != null ? [var.settings.github_configuration] : []

    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }
  dynamic "global_parameter" {
    for_each = try(var.settings.global_parameter, null) != null ? [var.settings.global_parameter] : []

    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = concat(local.managed_identities, try(identity.value.identity_ids, []))
    }
  }

  dynamic "vsts_configuration" {
    for_each = try(var.settings.vsts_configuration, null) != null ? [var.settings.vsts_configuration] : []

    content {
      account_name    = vsts_configuration.value.account_name
      branch_name     = vsts_configuration.value.branch_name
      project_name    = vsts_configuration.value.project_name
      repository_name = vsts_configuration.value.repository_name
      root_folder     = vsts_configuration.value.root_folder
      tenant_id       = vsts_configuration.value.tenant_id
    }
  }
  managed_virtual_network_enabled = try(var.settings.managed_virtual_network_enabled, null)
  public_network_enabled          = try(var.settings.public_network_enabled, null)
  #customer_managed_key_id         = try(var.settings.customer_managed_key_id)
  tags = local.tags
}
