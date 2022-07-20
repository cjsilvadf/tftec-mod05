resource "azurerm_public_ip" "pipipvm-win-on" {
  name                = "pipvm-win-on"
  location            = var.az_rg_Location_australiacentral
  resource_group_name = azurerm_resource_group.ResGroupgonpremises.name
  allocation_method   = "Static"
  tags                = merge(var.tags, { treinamento = "terraform" }, )
}


resource "azurerm_network_interface" "nic-vm-win-on" {
  count               = "1"
  name                = "vm-win0${count.index + 1}-on"
  location            = var.az_rg_Location_australiacentral
  resource_group_name = azurerm_resource_group.ResGroupgonpremises.name

  ip_configuration {
    name                          = "nic-ipconfig-${count.index + 1}-on"
    subnet_id                     = azurerm_subnet.ResSubnet-On-Premises[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipipvm-win-on.id
  }
}

resource "azurerm_windows_virtual_machine" "ResVMWindows-on" {
  count                 = "1"
  name                  = "VM-FW-On"
  location              = var.az_rg_Location_australiacentral
  resource_group_name   = azurerm_resource_group.ResGroupgonpremises.name
  size                  = var.vmsize_win
  admin_username        = var.admin_login
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic-vm-win-on[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  tags = merge(var.tags_vnet, { treinamento = "terraform" }, )

}


resource "azurerm_dev_test_global_vm_shutdown_schedule" "ResShutdownVMwin-on" {
  count              = "1"
  virtual_machine_id = azurerm_windows_virtual_machine.ResVMWindows-on[count.index].id
  location           = var.az_rg_Location_australiacentral
  enabled            = true

  daily_recurrence_time = "1830"
  timezone              = "E. South America Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = var.time_in_minutes
    email           = var.email_notification
  }
}
