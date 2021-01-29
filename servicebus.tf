// Azure service bus
locals {
  topic_name        = "${var.product}-case-event-topic-${var.env}"
  subscription_name = "${var.product}-case-event-subscription-${var.env}"
  servicebus_namespace_name       = "${var.product}-servicebus-${var.env}"
  resource_group_name             = azurerm_resource_group.rg.name

}

//Create namespace
module "servicebus-namespace" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-namespace?ref=master"
  name                = local.servicebus_namespace_name
  location            = var.location
  resource_group_name = local.resource_group_name
  env                 = var.env
  common_tags         = var.common_tags
  sku                 = "Premium"
}

//Create topic
module "topic" {
  source                = "git@github.com:hmcts/terraform-module-servicebus-topic?ref=master"
  name                  = local.topic_name
  namespace_name        = module.servicebus-namespace.name
  resource_group_name   = local.resource_group_name
}

//Create subscription
module "subscription" {
//  The branch require_session needs to be merged to master
  source                = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=require_session"
  name                  = local.subscription_name
  namespace_name        = module.servicebus-namespace.name
  topic_name            = module.topic.name
  resource_group_name   = local.resource_group_name
  requires_session      = true
}
