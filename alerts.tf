module "wa-exception-alert" {
  source = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name = "wa-dlq-alert"
  alert_desc = "Triggers when a message falls into the Dead Letter Queue, works with 5 minute poll in wa-${var.env}."
  app_insights_query = "union traces, exceptions | where customDimensions[\"LoggingLevel\"] == \"WARN\" and customDimensions[\"Logger Message\"] contains \"dead lettered\" | sort by timestamp desc"
  custom_email_subject = "Alert: Message was dead-lettered in wa-${var.env}"
  frequency_in_minutes = 5
  time_window_in_minutes = 5
  severity_level = "2"
  action_group_name = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold = 0
  resourcegroup_name = azurerm_resource_group.rg.name
  enabled = true
  common_tags = local.common_tags
}

module "wa-camunda-task-unconfigured-exception-alert" {
  source = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "camunda-bpm-appinsights-${var.env}"

  alert_name = "wa-camunda-task-unconfigured-alert"
  alert_desc = "Triggers when a task could not be configured and it is saved with an unconfigured task state, works with 60 minute poll in camunda-bpm-appinsights-${var.env}."
  app_insights_query = "union traces, exceptions | where customDimensions[\"LoggingLevel\"] == \"WARN\" and message contains \"Task could not be configured. Task state was set to 'unconfigured'\" | sort by timestamp desc"
  custom_email_subject = "Alert: A task could not be configure in wa-${var.env}"
  frequency_in_minutes = 60
  time_window_in_minutes = 60
  severity_level = "2"
  action_group_name = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold = 0
  resourcegroup_name = "camunda-${var.env}"
  enabled = true
  common_tags = local.common_tags
}

module "wa-messages-find-problem-messages-alert" {
  source = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name = "wa-case-event-handler-find-problem-messages-alert"
  alert_desc = "Triggers when a ccd message is unprocessable state or remains in ready state for more than 1 hour, works with 60 minute poll in case-event-handler-appinsights-${var.env}."
  app_insights_query = "union traces | where customDimensions[\"LoggingLevel\"] == \"INFO\" and message contains \"FIND_PROBLEM_MESSAGES Retrieved problem messages\" and ( message contains \"UNPROCESSABLE\" or message contains \"READY\") | sort by timestamp desc"
  custom_email_subject = "Alert: some CCD messages could not be processed in wa-${var.env}"
  frequency_in_minutes = 60
  time_window_in_minutes = 60
  severity_level = "2"
  action_group_name = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold = 0
  resourcegroup_name =azurerm_resource_group.rg.name
  common_tags = local.common_tags
  enabled = true
}
