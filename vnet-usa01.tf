resource "azurerm_virtual_network" "ResVnet-eastus2" {
  name                = var.resource_vnet_name_vnet_usa01
  location            = var.az_vnet_Location_eastus
  resource_group_name = azurerm_resource_group.ResGroup.name
  address_space       = var.address_vnet_usa01
  tags                = merge(var.tags_vnet, { treinamento = "terraform" }, )
}
resource "azurerm_subnet" "ResSubnet-eastus2" {
  count                = length(var.resource_subnet_name_vnet_usa01)
  name                 = var.resource_subnet_name_vnet_usa01[count.index]
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-eastus2.name
  address_prefixes     = [var.address_prefix_subnet_vnet_usa01[count.index]]
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-eastus2.name
  address_prefixes     = ["10.1.255.224/27"]
}
resource "azurerm_public_ip" "pipVNGW" {
  name                = "PIP-VNG01"
  location            = var.az_vnet_Location_eastus
  resource_group_name = azurerm_resource_group.ResGroup.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "ResVNGW" {
  name                = "ResVNGW"
  location            = var.az_vnet_Location_eastus
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