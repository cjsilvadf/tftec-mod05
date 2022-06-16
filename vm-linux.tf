resource "azurerm_public_ip" "pipipvm-lnx" {
  name                = "var.pipvm-lxn"
  location            = var.az_vnet_Location_eastus
  resource_group_name = azurerm_resource_group.ResGroup.name
  allocation_method   = "Static"
  tags                = merge(var.tags, { treinamento = "terraform" }, )
}
#
# Create network interface
resource "azurerm_network_interface" "nic-vm-lnx" {
  count               = "1"
  name                = "vm-lnx0${count.index + 1}"
  location            = var.az_vnet_Location_eastus
  resource_group_name = azurerm_resource_group.ResGroup.name

  ip_configuration {
    name                          = "nic-ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.ResSubnet-eastus2[count.index + 1].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipipvm-lnx.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_linux_virtual_machine" "Resvmlnx" {
  count                 = "1"
  name                  = "VM-LNX01"
  location              = var.az_vnet_Location_eastus
  resource_group_name   = azurerm_resource_group.ResGroup.name
  network_interface_ids = [azurerm_network_interface.nic-vm-lnx[count.index].id]
  size                  = var.linux_vm_size
  # (resource arguments)
  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "VM-LNX01"
  admin_username                  = var.admin_login
  admin_password                  = var.admin_password
  disable_password_authentication = false

  tags = merge(var.tags_vnet, { treinamento = "terraform" }, )

}