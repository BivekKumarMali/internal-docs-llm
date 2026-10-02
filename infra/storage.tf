resource "azurerm_storage_account" "storage" {
  name                     = "${local.storage_account_prefix}"
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
