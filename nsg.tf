# Create Network Security Group and rule
resource "azurerm_network_security_group" "ResNGS" {
    name                = var.resource_nsg
    location            = azurerm_resource_group.ResGroup.location
    resource_group_name = azurerm_resource_group.ResGroup.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}