resource"azurerm_virtual_machine" "vm" {
 for_each              = var.vms
 name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.size

  storage_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = each.value.os_disk_caching
    create_option     = each.value.os_disk_create_option
    managed_disk_type = each.value.os_disk_managed_disk_type
  }

  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

data"azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

variable"vms"{}