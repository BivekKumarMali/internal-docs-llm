# Random suffix so the storage account name doesn't collide with someone
# else's account anywhere in Azure (storage account names are globally
# unique, unlike most other Azure resource names). Don't remove this —
# "internaldocsllm" alone is specific enough to probably be free right now,
# but there's no guarantee, and a naming collision fails the whole apply.
resource "random_string" "storage_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "${local.storage_account_prefix}st${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.rag_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Lowest-cost redundancy for dev/test

  public_network_access_enabled = true

  tags = local.common_tags
}

# Container inside storage account to hold your documents
resource "azurerm_storage_container" "documents" {
  name                  = "documents"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}
