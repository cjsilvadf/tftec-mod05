resource "azurerm_virtual_network" "ResVnet-On-Premises" {
  name                = var.resource_vnet_name_vnet_onpremises
  location            = var.az_rg_Location_australiacentral
  resource_group_name = azurerm_resource_group.ResGroupgonpremises.name
  address_space       = var.address_vnet_onpremises
  tags                = merge(var.tags_vnet, { treinamento = "terraform" }, )
}
resource "azurerm_subnet" "ResSubnet-On-Premises" {
  count                = length(var.resource_subnet_name_vnet_onpremises)
  name                 = var.resource_subnet_name_vnet_onpremises[count.index]
  resource_group_name  = azurerm_resource_group.ResGroupgonpremises.name
  virtual_network_name = azurerm_virtual_network.ResVnet-On-Premises.name
  address_prefixes     = [var.address_prefix_subnet_vnet_onpremises[count.index]]
}