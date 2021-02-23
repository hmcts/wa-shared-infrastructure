// Azure service bus
locals {
  topic_name        = "ccd-case-events-${var.env}"
  subscription_name = "${var.product}-case-events-sub-${var.env}"
  servicebus_namespace_name       = "ccd-servicebus-${var.env}"
  resource_group_name             = "ccd-shared-${var.env}"

}

//Create subscription
module "subscription" {
  source                = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                  = local.subscription_name
  namespace_name        = local.servicebus_namespace_name
  topic_name            = local.topic_name
  resource_group_name   = local.resource_group_name
  requires_session      = true
  lock_duration         = "PT30S"
}

resource "azurerm_key_vault_secret" "servicebus_primary_connection_string" {
  name      = "sb-primary-connection-string"
  value     = module.subscription.primary_send_and_listen_connection_string
  key_vault_id = data.azurerm_key_vault.wa-key-vault.id
}

output "sb_primary_send_and_listen_connection_string" {
  value = module.subscription.primary_send_and_listen_connection_string
}
