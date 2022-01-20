// Azure service bus
locals {
  topic_name                        = "ccd-case-events-${var.env}"
  subscription_name                 = "${var.product}-case-events-sub-${var.env}"
  subscription_rule_name            = "${var.product}-case-events-sub-rule-${var.env}"
  servicebus_namespace_name         = "ccd-servicebus-${var.env}"
  resource_group_name               = "ccd-shared-${var.env}"
  ccd_case_events_subscription_name = "${var.product}-ccd-case-events-sub-${var.env}"
}

//Create subscription
module "subscription" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                = local.subscription_name
  namespace_name      = local.servicebus_namespace_name
  topic_name          = local.topic_name
  resource_group_name = local.resource_group_name
  requires_session    = true
  lock_duration       = "PT30S"
}

//Create ccd case events subscription
module "ccd_case_event_subscription" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                = local.ccd_case_events_subscription_name
  namespace_name      = local.servicebus_namespace_name
  topic_name          = local.topic_name
  resource_group_name = local.resource_group_name
  requires_session    = true
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "allowed_jurisdictions" {
  name                = local.subscription_rule_name
  resource_group_name = local.resource_group_name
  namespace_name      = local.servicebus_namespace_name
  topic_name          = local.topic_name
  subscription_name   = local.subscription_name
  filter_type         = "SqlFilter"
  sql_filter          = "1=1"
}

resource "azurerm_servicebus_subscription_rule" "message_context" {
  count               = var.env == "aat" ? 1 : 0
  name                = local.subscription_rule_name
  resource_group_name = local.resource_group_name
  namespace_name      = local.servicebus_namespace_name
  topic_name          = local.topic_name
  subscription_name   = local.subscription_name
  filter_type         = "SqlFilter"
  sql_filter          = "message_context LIKE 'wa-ft%'"
}
