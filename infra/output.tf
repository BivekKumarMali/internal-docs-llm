output "resource_group_name" {
  value = azurerm_resource_group.rag_rg.name
}

# Outputs to use in your test app / API client
output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}

output "openai_primary_key" {
  value     = azurerm_cognitive_account.openai.primary_access_key
  sensitive = true
}

output "search_service_endpoint" {
  description = "Azure AI Search Endpoint URL"
  value       = "https://${azurerm_search_service.search.name}.search.windows.net"
}

output "search_service_primary_key" {
  description = "Azure AI Search Admin Primary Key"
  value       = azurerm_search_service.search.primary_key
  sensitive   = true
}