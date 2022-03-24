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
}

module "wa-camunda-task-uninitiated-exception-alert" {
  source = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name = "wa-camunda-task-uninitiated-alert"
  alert_desc = "Triggers when a task could not be initiated and it is saved with an unconfigured task state, works with 60 minute poll in camunda-bpm-appinsights-${var.env}."
  app_insights_query = "union traces, exceptions | where customDimensions[\"LoggingLevel\"] == \"WARN\" and message contains \"TASK_INITIATION_FAILURES There are some uninitiated tasks\" | sort by timestamp desc"
  custom_email_subject = "Alert: A task could not be initiated in wa-${var.env}"
  frequency_in_minutes = 5
  time_window_in_minutes = 5
  severity_level = "2"
  action_group_name = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold = 0
  resourcegroup_name = "camunda-${var.env}"
  enabled = true
}
