module "wa-exception-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-dlq-alert"
  alert_desc                 = "Triggers when a message falls into the Dead Letter Queue, works with 5 minute poll in wa-${var.env}."
  app_insights_query         = "union traces, exceptions | where customDimensions[\"Logger Message\"] contains \"dead lettered\" | sort by timestamp desc"
  custom_email_subject       = "Alert: Message was dead-lettered in wa-${var.env}"
  frequency_in_minutes       = "5"
  time_window_in_minutes     = "5"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = true
}

module "wa-camunda-task-uninitiated-exception-alert-summary" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-camunda-task-uninitiated-alert-weekly"
  alert_desc                 = "Triggers when a task could not be initiated and it is saved with an unconfigured task state, runs a summary report every 7 days in wa-${var.env}."
  app_insights_query         = "union traces, exceptions | where message contains \"TASK_INITIATION_FAILURES There are some uninitiated tasks\" | sort by timestamp desc"
  custom_email_subject       = "Alert: A task could not be initiated in wa-${var.env}"
  frequency_in_minutes       = "10800"
  time_window_in_minutes     = "10800"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = false
}

module "wa-camunda-task-uninitiated-exception-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name          = "wa-${var.env}"
  alert_name                 = "wa-camunda-task-uninitiated-alert"
  alert_desc                 = "Triggers when a task could not be initiated and it is saved with an unconfigured task state, works with 60 minute poll in wa-${var.env}"
  app_insights_query         = "traces | project timestamp, msg=message | union (exceptions | project timestamp, msg=outerMessage) | where msg has_all (\"TASK_INITIATION_FAILURES There are some uninitiated tasks\") | parse kind=relaxed msg with * \"created: \" created_iso \"Z\" * | extend created_str = strcat(created_iso, \"Z\") | extend created = todatetime(created_str) | where isnotempty(created) and created >= ago(18h) | project timestamp, created, msg"
  custom_email_subject       = "Alert: A task could not be initiated in wa-${var.env}"
  frequency_in_minutes       = "60"
  time_window_in_minutes     = "60"
  severity_level             = "2"
  action_group_name          = "wa-support-${var.env}"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = var.enable-tm-slack-alert
}

module "wa-camunda-task-unterminated-exception-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-camunda-task-unterminated-alert"
  alert_desc                 = "Triggers when a task could not be terminated, works with 120 minute poll in wa-${var.env}."
  app_insights_query         = "union traces, exceptions | where message contains \"TASK_TERMINATION_FAILURES There are some unterminated tasks\" | sort by timestamp desc"
  custom_email_subject       = "Alert: A task could not be terminated in wa-${var.env}"
  frequency_in_minutes       = "60"
  time_window_in_minutes     = "60"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = true
}

module "wa-messages-find-problem-messages-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-case-event-handler-find-problem-messages-alert"
  alert_desc                 = "Triggers when a ccd message is unprocessable state or remains in ready state for more than 1 hour, works with 60 minute poll in case-event-handler-appinsights-${var.env}."
  app_insights_query         = "union traces | where message contains \"FIND_PROBLEM_MESSAGES Retrieved problem messages\" and ( message contains \"UNPROCESSABLE\" or message contains \"READY\") | sort by timestamp desc"
  custom_email_subject       = "Alert: some CCD messages could not be processed in wa-${var.env}"
  frequency_in_minutes       = "60"
  time_window_in_minutes     = "60"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = true
}

module "wa-cft-task-reconfiguration-exception-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-task-management-api-reconfiguration-exception-alert"
  alert_desc                 = "Triggers when a task could not be reconfigured for a defined time in task-management-api-appinsights-${var.env}."
  app_insights_query         = "union traces | where message contains \"Task Execute Reconfiguration Failed\" | sort by timestamp desc"
  custom_email_subject       = "Alert: some tasks could not be reconfigured in wa-${var.env}"
  frequency_in_minutes       = "60"
  time_window_in_minutes     = "60"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = true
}

module "wa-task-replication-problem-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name                 = "wa-task-management-api-replication-problem-alert"
  alert_desc                 = "Triggers when a task could not be replicated in task-management-api-appinsights-${var.env}."
  app_insights_query         = "union traces | where message contains \"TASK_REPLICATION_ERROR: \" | sort by timestamp desc"
  custom_email_subject       = "Alert: some tasks could not be replicated in wa-${var.env}"
  frequency_in_minutes       = "60"
  time_window_in_minutes     = "60"
  severity_level             = "2"
  action_group_name          = "wa-support"
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  common_tags                = var.common_tags
  enabled                    = true
}

module "wa-task-deletion-failure-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name           = "wa-task-management-api-task-deletion-failure-alert"
  alert_desc           = "Alert when task fail to delete for case id"
  app_insights_query   = "traces | where message contains 'Unable to delete all tasks for case id:' or message contains 'Deleted some UNTERMINATED tasks:'"
  custom_email_subject = "Alert: Task deletion failure in wa-${var.env}"
  #run every 6 hrs for early alert
  frequency_in_minutes = "360"
  # window of 1 day as data extract needs to run daily
  time_window_in_minutes     = "1440"
  severity_level             = "2"
  action_group_name          = module.wa-action-group.action_group_name
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  enabled                    = var.enable-wa-task-management-api-task-deletion-failure-alert
  common_tags                = var.common_tags
}

module "wa-message-readiness-check-failure-alert" {
  source   = "git@github.com:hmcts/cnp-module-metric-alert"
  location = var.location

  app_insights_name = "wa-${var.env}"

  alert_name           = "wa-case-event-handler-message-readiness-check-failure-alert"
  alert_desc           = "Alert when case event handler message readiness check fails and auto restart of pod happens"
  app_insights_query   = "traces | where message contains 'Liveness check failed' or message contains 'Readiness check failed'"
  custom_email_subject = "Alert: Task readiness message checks failed wa-${var.env}"
  #run every 3 hrs for early alert
  frequency_in_minutes = "180"
  # window of 1 day as data extract needs to run daily
  time_window_in_minutes     = "1440"
  severity_level             = "2"
  action_group_name          = module.wa-action-group.action_group_name
  trigger_threshold_operator = "GreaterThan"
  trigger_threshold          = "0"
  resourcegroup_name         = azurerm_resource_group.rg.name
  enabled                    = true
  common_tags                = var.common_tags
}
