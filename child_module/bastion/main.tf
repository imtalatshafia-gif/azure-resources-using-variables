resource"azurerm_bastion_host""bastion"{
    for_each=var.bastion
    name=each.value.name
    location=each.value.location
    resource_group_name=each.value.resource_group_name
    
    ip_configuration{
        name=each.value.name
        subnet_id=data.azurerm_subnet.subnet[each.key].id
        public_ip_address_id=data.azurerm_public_ip.public_ip[each.key].id
    }
}
data"azurerm_subnet""subnet"{
    for_each=var.bastion
name=each.value.name
    virtual_network_name=each.value.virtual_network_name
    resource_group_name=each.value.resource_group_name
}
data"azurerm_public_ip""public_ip"{
    for_each=var.bastion
    name=each.value.name
    resource_group_name=each.value.resource_group_name
}


variable"bastion"{}