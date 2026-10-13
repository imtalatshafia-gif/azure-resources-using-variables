resource "azurerm_storage_account" "rgstorage" {
  for_each = var.storage
  name     = each.value.storage_account_name
  location = each.value.location
  resource_group_name=each.value.resource_group_name
  account_replication_type=each.value.account_replication_type
  account_tier=each.value.account_tier
}

variable "storage" {}