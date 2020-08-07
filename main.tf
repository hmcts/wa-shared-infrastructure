provider "azurerm" {
  version = "1.44.0"
}

locals {
  common_tags = {
    "environment"  = "${var.env}"
    "Team Name"    = "${var.team_name}"
    "Team Contact" = "${var.team_contact}"
    "Destroy Me"   = "${var.destroy_me}"
  }

  managed_identity_object_id = "${var.managed_identity_object_id}"
}
