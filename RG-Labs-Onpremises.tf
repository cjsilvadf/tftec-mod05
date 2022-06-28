resource "azurerm_resource_group" "ResGroupgonpremises" {
  name     = var.resource_group_onpremises
  location = var.az_rg_Location_australiacentral
  tags     = merge(var.tags, { treinamento = "terraform" }, )

}