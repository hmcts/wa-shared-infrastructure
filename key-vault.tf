locals {
  key_vault_name = "${var.product}-${var.env}"
}

module "wa_key_vault" {
  source                  = "git@github.com:hmcts/cnp-module-key-vault?ref=DTSPO-31965/remove-jenkins-ptl-access"
  name                    = local.key_vault_name
  product                 = var.product
  env                     = var.env
  tenant_id               = var.tenant_id
  object_id               = var.jenkins_AAD_objectId
  jenkins_object_id       = data.azurerm_user_assigned_identity.jenkins.principal_id
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_object_id = var.wa_product_group_object_id

  location                             = var.location
  common_tags                          = var.common_tags
  create_managed_identity              = true
  additional_managed_identities_access = var.additional_managed_identities_access

  grant_preview_jenkins_access = var.env == "aat"
}

data "azurerm_user_assigned_identity" "jenkins" {
  name                = "jenkins-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
}

