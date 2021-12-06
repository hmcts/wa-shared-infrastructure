// Azure service bus
locals {
  topic_name        = "ccd-case-events-${var.env}"
  subscription_name = "${var.product}-case-events-sub-${var.env}"
  servicebus_namespace_name       = "ccd-servicebus-${var.env}"
  resource_group_name             = "ccd-shared-${var.env}"
  ccd_case_events_subscription_name = "${var.product}-ccd-case-events-sub-${var.env}"
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

//Create ccd case events subscription
module "ccd_case_event_subscription" {
  source                = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                  = local.ccd_case_events_subscription_name
  namespace_name        = local.servicebus_namespace_name
  topic_name            = local.topic_name
  resource_group_name   = local.resource_group_name
  requires_session      = true
  lock_duration         = "PT30S"
}
