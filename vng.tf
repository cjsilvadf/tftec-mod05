resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-centralus.name
  address_prefixes     = ["10.1.255.224/27"]
}
resource "azurerm_public_ip" "pipVNGW" {
  name                = "PIP-VNG01"
  location            = var.az_vnet_Location_centralus
  resource_group_name = azurerm_resource_group.ResGroup.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "ResVNGW" {
  name                = "ResVNGW"
  location            = var.az_vnet_Location_centralus
  resource_group_name = azurerm_resource_group.ResGroup.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    //name                          = "vnetGatewayConfig-${count.index + 1}"
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pipVNGW.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
  }

}