// WA Alerts Action Groups

data "azurerm_key_vault_secret" "wa_support_email" {
  name      = "wa-support-email"
  key_vault_id = data.azurerm_key_vault.wa_key_vault.id
}

module "wa-action-group" {
  source   = "git@github.com:hmcts/cnp-module-action-group"
  location = "global"
  env      = var.env

  resourcegroup_name     = "${azurerm_resource_group.rg.name}"
  action_group_name      = "wa-support"
  short_name             = "wa-support"
  email_receiver_name    = "WA Support Mailing List"
  email_receiver_address = "wa-support@HMCTS.NET"
}
