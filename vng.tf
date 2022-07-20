resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ResGroup.name
  virtual_network_name = azurerm_virtual_network.ResVnet-centralus.name
  address_prefixes     = var.address_GatewaySubnet
}

resource "azurerm_public_ip" "pipVNGW" {
  name                = "PIP-VNG01"
  location            = var.az_vnet_Location_centralus
  resource_group_name = azurerm_resource_group.ResGroup.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "ResVNGW" {
  name                = var.virtual_network_gateway_name
  location            = var.az_vnet_Location_centralus
  resource_group_name = azurerm_resource_group.ResGroup.name
  type     = "Vpn"
  vpn_type = "RouteBased"
  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = var.ip_configuration_name
    public_ip_address_id          = azurerm_public_ip.pipVNGW.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
  }
  
  vpn_client_configuration {
    aad_audience         = var.audience
    aad_issuer           = var.issuer
    aad_tenant           = var.tenant
    address_space        = var.address_vpn_client_configuration
    vpn_auth_types       = ["AAD"]
    vpn_client_protocols = ["OpenVPN"]

  }
     tags = {
      ProjectName  = "MOD05-LABS"
      Env          = "Treinamento"
      Owner        = "teste@teste.com"
      BusinessUnit = "CORP"
      ServiceClass = "Gold"
      }
#
}
