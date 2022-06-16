resource "azurerm_virtual_network" "ResVnet-brazilsouth" {
  name                = var.resource_vnet_name_vnet_bra01
  location            = var.az_vnet_Location_brazilsouth
  resource_group_name = azurerm_resource_group.ResGroup.name
  address_space       = var.address_vnet_bra01
  tags                = merge(var.tags_vnet, { treinamento = "terraform" }, )
}
resource "azurerm_subnet" "ResSubnet-brazilsouth" {
  count                = length(var.resource_subnet_name_vnet_bra01)
  name                 = var.resource_subnet_name_vnet_bra01[count.index]
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-brazilsouth.name
  address_prefixes     = [var.address_prefix_subnet_vnet_bra01[count.index]]
}