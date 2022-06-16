resource "azurerm_virtual_network" "ResVnet-westeurope" {
  name                = var.resource_vnet_name_vnet_eur01
  location            = var.az_vnet_Location_westeurope
  resource_group_name = azurerm_resource_group.ResGroup.name
  address_space       = var.address_vnet_eur01
  tags                = merge(var.tags_vnet, { treinamento = "terraform" }, )
}
resource "azurerm_subnet" "ResSubnet-westeurope" {
  count                = length(var.resource_subnet_name_vnet_eur01)
  name                 = var.resource_subnet_name_vnet_eur01[count.index]
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-westeurope.name
  address_prefixes     = [var.address_prefix_subnet_vnet_eur01[count.index]]
}
#
