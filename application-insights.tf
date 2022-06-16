locals {
  appinsights_name = "${var.product}-${var.env}"
}

resource "azurerm_application_insights" "appinsights" {
  name                = local.appinsights_name
  location            = var.appinsights_location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = var.appinsights_application_type
  tags                = var.common_tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to appinsights as otherwise upgrading to the Azure provider 2.x
      # destroys and re-creates this appinsights instance
      application_type,
    ]
  }
}

output "appInsightsName" {
  value = local.appinsights_name
}

output "appInsightsInstrumentationKey" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}

resource "azurerm_key_vault_secret" "app_insights_connection_string" {
  name         = "app-insights-connection-string"
  value        = azurerm_application_insights.appinsights.connection_string
  key_vault_id = module.wa_key_vault.key_vault_id
}

resource "azurerm_key_vault_secret" "AZURE_APPINSGHTS_KEY" {
  name         = "AppInsightsInstrumentationKey"
  value        = azurerm_application_insights.appinsights.instrumentation_key
  key_vault_id = module.wa_key_vault.key_vault_id
}

