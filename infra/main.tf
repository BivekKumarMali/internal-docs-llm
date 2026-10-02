resource "azurerm_resource_group" "rag_rg" {
  location = var.location
  name     = local.resource-gp-name
  tags     = local.common_tags
}
