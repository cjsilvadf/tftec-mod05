resource "azurerm_resource_group" "ResGroup" {
  name     = var.resource_group
  location = var.az_rg_Location_eastus
  tags     = merge(var.tags, { treinamento = "terraform" }, )
}