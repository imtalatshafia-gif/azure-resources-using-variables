module "resource_group" {
  source = "../child_module/resource_group"
  rgs    = var.rootresource
}

module "storage_account" {

  source     = "../child_module/storage_account"
  storage    = var.rootstorage
  depends_on = [module.resource_group]
}

module "virtual_network" {
  source           = "../child_module/virtual_network"
  virtual_networks = var.rootvirtual_network
  depends_on       = [module.resource_group]
}

module "vnet_peering" {
  source     = "../child_module/vnet_peering"
  vnets      = var.rootvnet_peering
  depends_on = [module.virtual_network]
}

module "subnet" {
  source     = "../child_module/subnet"
  subnets    = var.rootsubnet
  depends_on = [module.virtual_network]
}

module "public_ip" {
  source     = "../child_module/public_ip"
  public_ips = var.rootpublic_ip
  depends_on = [module.resource_group]
}

module "network_interface" {
  source             = "../child_module/network_interface"
  network_interfaces = var.rootnetwork_interface
  depends_on         = [module.subnet, module.public_ip]
}

module "virtual_machine" {
  source     = "../child_module/virtual_machine"
  vms        = var.rootvirtual_machine
  depends_on = [module.network_interface, module.storage_account]
}

module "bastion_host" {
  source     = "../child_module/bastion"
  bastion    = var.bastion_host
  depends_on = [module.subnet, module.public_ip]
}

