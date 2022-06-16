resource "azurerm_public_ip" "pipipvm-win" {
  name                = "pipvm-win"
  location            = var.az_vnet_Location_brazilsouth
  resource_group_name = azurerm_resource_group.ResGroup.name
  allocation_method   = "Static"
  tags                = merge(var.tags, { treinamento = "terraform" }, )
}


resource "azurerm_network_interface" "nic-vm-win" {
  count               = "1"
  name                = "vm-win0${count.index + 1}"
  location            = var.az_vnet_Location_brazilsouth
  resource_group_name = azurerm_resource_group.ResGroup.name

  ip_configuration {
    name                          = "nic-ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.ResSubnet-brazilsouth[count.index + 1].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipipvm-win.id
  }
}

resource "azurerm_windows_virtual_machine" "ResVMWindows" {
  count                 = "1"
  name                  = "VM-WIN01"
  location              = var.az_vnet_Location_brazilsouth
  resource_group_name   = azurerm_resource_group.ResGroup.name
  size                  = var.vmsize_win
  admin_username        = var.admin_login
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic-vm-win[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  tags = merge(var.tags_vnet, { treinamento = "terraform" }, )

}