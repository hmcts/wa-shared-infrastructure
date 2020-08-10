locals {
  appinsights_name = "${var.product}-${var.env}"
}

resource "azurerm_application_insights" "appinsights" {
  name                = "${local.appinsights_name}"
  location            = "${var.appinsights_location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  application_type    = "${var.appinsights_application_type}"
  tags                = "${local.common_tags}"
}

output "appInsightsName" {
  value = "${local.appinsights_name}"
}

output "appInsightsInstrumentationKey" {
  value = "${azurerm_application_insights.appinsights.instrumentation_key}"
}
