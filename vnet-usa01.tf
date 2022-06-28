resource "azurerm_virtual_network" "ResVnet-centralus" {
  name                = var.resource_vnet_name_vnet_usa01
  location            = var.az_vnet_Location_centralus
  resource_group_name = azurerm_resource_group.ResGroup.name
  address_space       = var.address_vnet_usa01
  tags                = merge(var.tags_vnet, { treinamento = "terraform" }, )
}

resource "azurerm_subnet" "ResSubnet-centralus" {
  count                = length(var.resource_subnet_name_vnet_usa01)
  name                 = var.resource_subnet_name_vnet_usa01[count.index]
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-centralus.name
  address_prefixes     = [var.address_prefix_subnet_vnet_usa01[count.index]]
}
#