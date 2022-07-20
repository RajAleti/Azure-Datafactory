
resource "azurerm_data_factory_pipeline" "pipeline" {
  name                           = var.name
  resource_group_name            = var.resource_group_name
  data_factory_id                = var.data_factory_id
  description                    = try(var.settings.description, null)
  annotations                    = try(var.settings.annotations, null)
  concurrency                    = try(var.settings.concurrency, null)
  folder                         = try(var.settings.folder, null)
  moniter_metrics_after_duration = try(var.settings.moniter_metrics_after_duration, null)
  parameters                     = try(var.settings.parameters, null)
  variables                      = try(var.settings.variables, null)
  activities_json                = try(var.settings.activities_json, null)
}