resource"azurerm_network_interface""nic"{
    for_each=var.network_interfaces
    name=each.value.name
    location=each.value.location
    resource_group_name=each.value.resource_group_name  

    ip_configuration{
    name=each.value.ip_name
    subnet_id=data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation=each.value.private_ip_address_allocation
    
   

}
}
data"azurerm_subnet""subnet"{
    for_each=var.network_interfaces
    name=each.value.subnet_name
    virtual_network_name=each.value.virtual_network_name
    resource_group_name=each.value.resource_group_name
}

variable"network_interfaces"{}