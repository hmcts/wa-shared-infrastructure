// Azure service bus
locals {
  topic_name                        = "ccd-case-events-${var.env}"
  servicebus_namespace_name         = "ccd-servicebus-${var.env}"
  resource_group_name               = "ccd-shared-${var.env}"
  ccd_case_events_subscription_name = "${var.product}-ccd-case-events-sub-${var.env}"
  # This Expression helps create the instance only in aat by setting the count in aat to 1 and 0 on other envs.
  message_context_instances_count = var.env == "aat" ? 1 : 0
  # This Expression helps create the instance in all environments apart from AAT by setting the count to 0 in aat.
  case_events_sub_rule_instances_count = var.env == "aat" ? 0 : 1
}

//Create ccd case events subscription
module "ccd_case_event_subscription" {
  source           = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=4.x"
  namespace_id     = data.azurerm_servicebus_namespace.namespace.id
  name             = local.ccd_case_events_subscription_name
  topic_name       = local.topic_name
  requires_session = true
  lock_duration    = "PT30S"
}

data "azurerm_servicebus_namespace" "namespace" {
  name                = local.servicebus_namespace_name
  resource_group_name = local.resource_group_name
}

resource "azurerm_servicebus_subscription_rule" "allowed_jurisdictions" {
  count           = local.case_events_sub_rule_instances_count
  name            = "${var.product}-case-events-sub-rule-${var.env}"
  subscription_id = module.ccd_case_event_subscription.id
  filter_type     = "SqlFilter"
  sql_filter      = "jurisdiction_id IN (${var.allowed_jurisdictions})"
}

resource "azurerm_servicebus_subscription_rule" "message_context" {
  count           = local.message_context_instances_count
  name            = "${var.product}-message-context-sub-rule-${var.env}"
  subscription_id = module.ccd_case_event_subscription.id
  filter_type     = "SqlFilter"
  sql_filter      = "jurisdiction_id IN (${var.allowed_jurisdictions})"
}
