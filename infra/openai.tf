resource "azurerm_cognitive_account" "openai" {
  name                = local.openai-name
  location            = var.location # Azure OpenAI isn't available in centralindia — see variables.tf
  kind                = "OpenAI"
  sku_name            = "S0"
  resource_group_name = azurerm_resource_group.rag_rg.name

  public_network_access_enabled = true

  tags = local.common_tags
}
# -----------------------------------------------------------------------------
# Azure OpenAI Model Deployments
# -----------------------------------------------------------------------------

# a. Chat Model Deployment (gpt-4o-mini)
resource "azurerm_cognitive_deployment" "chat_model" {
  name                 = var.chat_model_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  sku {
    name     = "GlobalStandard" 
    capacity = 1                
  }

  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"     
    version = "2024-07-18"      
  }

  version_upgrade_option = "OnceCurrentVersionExpired"
}

# Low-Cost Embedding Model Deployment for Testing (text-embedding-3-small)
resource "azurerm_cognitive_deployment" "embedding_model" {
  name                 = var.embedding_model_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  sku {
    name     = "GlobalStandard" 
    capacity = 1                
  }

  model {
    format  = "OpenAI"
    name    = "text-embedding-3-small"
    version = "1"                      
  }

  version_upgrade_option = "OnceCurrentVersionExpired" 
}


# -----------------------------------------------------------------------------
# 3. Azure AI Search Service (Basic Tier)
# -----------------------------------------------------------------------------
resource "azurerm_search_service" "search" {
  name                = local.search_service_name # Must be globally unique (lowercase)
  resource_group_name = azurerm_resource_group.rag_rg.name
  location            = var.location
  sku                 = "free"

  replica_count   = 1
  partition_count = 1

  public_network_access_enabled = true

  tags = local.common_tags
}
