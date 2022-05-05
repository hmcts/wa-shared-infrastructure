
resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}"
  location = var.location
  tags     = merge(var.common_tags, map("lastUpdated", timestamp()))
}

output "resourceGroup" {
  value = azurerm_resource_group.rg.name
}
