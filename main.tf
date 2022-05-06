provider "azurerm" {
  features {}
}

locals {
  managed_identity_object_id = var.managed_identity_object_id
}
