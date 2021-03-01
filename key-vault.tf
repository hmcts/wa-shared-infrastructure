locals {
  key_vault_name = "${var.product}-${var.env}"
}

module "wa_key_vault" {
  source                     = "git@github.com:hmcts/cnp-module-key-vault?ref=master"
  name                       = local.key_vault_name
  product                    = var.product
  env                        = var.env
  tenant_id                  = var.tenant_id
  object_id                  = var.jenkins_AAD_objectId
  resource_group_name        = azurerm_resource_group.rg.name
  product_group_object_id    = var.wa_product_group_object_id

  location                   = var.location
  common_tags                = local.common_tags
  create_managed_identity    = true
}
