 locals {
  client_config = var.client_config == {} ? {
    client_id               = data.azurerm_client_config.current.client_id
    landingzone_key         = var.current_landingzone_key
    logged_aad_app_objectId = local.object_id
    logged_user_objectId    = local.object_id
    object_id               = local.object_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
  } : map(var.client_config)
 


  data_factory = {
    data_factory                                 = try(var.data_factory.data_factory, {})
    data_factory_pipeline                        = try(var.data_factory.data_factory_pipeline, {})
    data_factory_trigger_schedule                = try(var.data_factory.data_factory_trigger_schedule, {})
    data_factory_integration_runtime_azure_ssis  = try(var.data_factory.data_factory_integration_runtime_azure_ssis, {})
    data_factory_integration_runtime_self_hosted = try(var.data_factory.data_factory_integration_runtime_self_hosted, {})
    
    
  }

 

  dynamic_app_settings_combined_objects = {
    networking                  = local.combined_objects_networking
  }

  dynamic_app_config_combined_objects = {
    
    client_config                = tomap({ (local.client_config.landingzone_key) = { config = local.client_config } })
    managed_identities           = local.combined_objects_managed_identities
    resource_groups              = local.combined_objects_resource_groups
  }

  global_settings = merge({
    default_region     = try(var.global_settings.default_region, "region1")
    environment        = try(var.global_settings.environment, var.environment)
    inherit_tags       = try(var.global_settings.inherit_tags, false)
    random_length      = try(var.global_settings.random_length, 0)
    regions            = try(var.global_settings.regions, null)
    tags               = try(var.global_settings.tags, null)
    use_slug           = try(var.global_settings.use_slug, true)
  }, var.global_settings)
  
}


locals {
  # Diagnostics services to create
  diagnostics = {
    diagnostic_event_hub_namespaces = try(var.diagnostics.diagnostic_event_hub_namespaces, {})
    diagnostic_log_analytics        = try(var.diagnostics.diagnostic_log_analytics, {})
    diagnostic_storage_accounts     = try(var.diagnostics.diagnostic_storage_accounts, {})
  }

  # Remote amd locally created diagnostics  objects
  combined_diagnostics = {
    diagnostics_definition   = try(var.diagnostics.diagnostics_definition, {})
    diagnostics_destinations = try(var.diagnostics.diagnostics_destinations, {})
    log_analytics            = merge(try(var.diagnostics.log_analytics, {}), module.diagnostic_log_analytics)
  }
}

output "diagnostics" {
  value = local.combined_diagnostics

}

locals {
  # CAF landing zones can retrieve remote objects from a different landing zone and the
  # combined_objects will merge it with the local objects
  combined_objects_data_factory                                   = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory }), try(var.remote_objects.data_factory, {}))
  combined_objects_data_factory_pipeline                          = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_pipeline }), try(var.remote_objects.data_factory_pipeline, {}))
  combined_objects_networking                                     = merge(tomap({ (local.client_config.landingzone_key) = module.networking }), try(var.remote_objects.vnets, {}))
  combined_objects_managed_identities                             = merge(tomap({ (local.client_config.landingzone_key) = module.managed_identities }), try(var.remote_objects.managed_identities, {}))
  combined_objects_private_dns                                    = merge(tomap({ (local.client_config.landingzone_key) = module.private_dns }), try(var.remote_objects.private_dns, {}))

  combined_objects_subscriptions = merge(
    tomap(
      {
        (local.client_config.landingzone_key) = merge(
          try(module.subscriptions, {}),
          { ("logged_in_subscription") = { id = data.azurerm_subscription.primary.id } }
        )
      }
    ),
    try(var.remote_objects.subscriptions, {})
  )

}
 
