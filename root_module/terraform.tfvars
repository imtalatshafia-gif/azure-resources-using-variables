rootresource = {
  rg1 = {
    name     = "priya"
    location = "eastus"

  }
  rg2 = {
    name     = "chanda"
    location = "westeurope"

  }
}


rootstorage = {

  st1 = {
    storage_account_name     = "fantastorage98"
    location                 = "eastus"
    resource_group_name      = "priya"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
  st2 = {
    storage_account_name     = "fantastorage189"
    location                 = "westeurope"
    resource_group_name      = "chanda"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
}

rootvirtual_network = {
  vnet1 = {
    name                = "priyavnet"
    resource_group_name = "priya"
    location            = "eastus"
    address_space       = ["10.34.0.0/16"]
  }

  vnet2 = {
    name                = "chandavnet"
    resource_group_name = "chanda"
    location            = "westeurope"
    address_space       = ["10.35.0.0/16"]
  }
}

rootvnet_peering = {
  vnetpeering1 = {
    name                      = "priyavnetpeering"
    virtual_network_name      = "priyavnet"
    remote_virtual_network_id = "chandavnet"
    resource_group_name      = "priya"
  }

  vnetpeering2 = {
    name                      = "chandavnetpeering"
    virtual_network_name      = "chandavnet"
    remote_virtual_network_id = "priyavnet"
    resource_group_name      = "chanda"
  }
}
rootsubnet = {
  subnet1 = {
    name                 = "priyasubnet"
    resource_group_name  = "priya"
    virtual_network_name = "priyavnet"
    address_prefixes     = ["10.34.1.0/24"]
  }

  subnet2 = {
    name                 = "chandasubnet"
    resource_group_name  = "chanda"
    virtual_network_name = "chandavnet"
    address_prefixes     = ["10.35.1.0/24"]
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "priya"
    virtual_network_name = "priyavnet"
    address_prefixes     = ["10.34.2.0/24"]
  }
}

rootnetwork_interface = {
  nic1 = {
    name                          = "priyanic"
    location                      = "eastus"
    resource_group_name           = "priya"
    virtual_network_name        = "priyavnet"
    subnet_name                  = "priyasubnet"
    ip_name                       = "priyaipconfig"
    private_ip_address_allocation = "Dynamic"
    ip_configuration = {
      subnet_id = "subnet1"
    }
  }

  nic2 = {
    name                          = "chandanic"
    location                      = "westeurope"
    resource_group_name           = "chanda"
    virtual_network_name        = "chandavnet"
    subnet_name                  = "chandasubnet"
    ip_name                       = "chandaipconfig"
    private_ip_address_allocation = "Dynamic"
    ip_configuration = {
      subnet_id = "subnet2"
    }
  }
}

rootpublic_ip = {
  publicip1 = {
    name                = "priyapublicip"
    location            = "eastus"
    resource_group_name = "priya"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  publicip2 = {
    name                = "chandapublicip"
    location            = "westeurope"
    resource_group_name = "chanda"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

rootvirtual_machine = {

  vm1 = {
    name                      = "frontendvm"
    location                  = "eastus"
    resource_group_name       = "priya"
    frontend_nic              = "vm1"
    size                      = "Standard_DS1_v2"
    image_publisher           = "Canonical"
    image_offer               = "UbuntuServer"
    image_sku                 = "18.04-LTS"
    image_version             = "latest"
    os_disk_caching           = "ReadWrite"
    os_disk_create_option     = "FromImage"
    os_disk_managed_disk_type = "Standard_LRS"
    computer_name             = "priyavm"
    admin_username            = "priyauser"
    admin_password            = "priya123"
  }

  vm2 = {
    name                      = "backendvm"
    location                  = "westeurope"
    resource_group_name       = "chanda"
    frontend_nic              = "vm2"
    size                      = "Standard_DS1_v2"
    image_publisher           = "Canonical"
    image_offer               = "UbuntuServer"
    image_sku                 = "18.04-LTS"
    image_version             = "latest"
    os_disk_caching           = "ReadWrite"
    os_disk_create_option     = "FromImage"
    os_disk_managed_disk_type = "Standard_LRS"
    computer_name             = "chandavm"
    admin_username            = "chandauser"
    admin_password            = "chanda123"
  }

}

bastion_host = {
  bastion1 = {
    name                 = "bastionhost"
    location             = "eastus"
    resource_group_name  = "priya"
    subnet_id            = "AzureBastionSubnet"
    public_ip_address_id = "data.azurerm_public_ip.public_ip[\"bastion1\"].id"
    virtual_network_name = "priyavnet"
    
  }
}