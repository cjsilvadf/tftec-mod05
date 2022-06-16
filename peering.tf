//PEER VNET-USA01 PARA VNET-EUR01
resource "azurerm_virtual_network_peering" "VNET-USA01-to-VNET-EUR01" {
  name                      = "VNET-USA01-to-VNET-EUR01"
  resource_group_name       = azurerm_resource_group.ResGroup.name
  virtual_network_name      = azurerm_virtual_network.ResVnet-eastus2.name
  remote_virtual_network_id = azurerm_virtual_network.ResVnet-westeurope.id
}

resource "azurerm_virtual_network_peering" "VNET-EUR01-to-VNET-USA01" {
  name                      = "VNET-EUR01-to-VNET-USA01"
  resource_group_name       = azurerm_resource_group.ResGroup.name
  virtual_network_name      = azurerm_virtual_network.ResVnet-westeurope.name
  remote_virtual_network_id = azurerm_virtual_network.ResVnet-eastus2.id
}
#PEER VNET-USA01 PARA VNET-BRA01
resource "azurerm_virtual_network_peering" "VNET-USA01-to-VNET-BRA01" {
  name                      = "VNET-USA01-to-VNET-BRA01"
  resource_group_name       = azurerm_resource_group.ResGroup.name
  virtual_network_name      = azurerm_virtual_network.ResVnet-eastus2.name
  remote_virtual_network_id = azurerm_virtual_network.ResVnet-brazilsouth.id
}
resource "azurerm_virtual_network_peering" "VNET-BRA01-to-VNET-USA01" {
  name                      = "VNET-BRA0101-to-VNET-USA01"
  resource_group_name       = azurerm_resource_group.ResGroup.name
  virtual_network_name      = azurerm_virtual_network.ResVnet-brazilsouth.name
  remote_virtual_network_id = azurerm_virtual_network.ResVnet-eastus2.id
}
