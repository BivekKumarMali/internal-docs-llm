resource "azurerm_cognitive_account" "openai" {
  name                = local.openai-name
  location            = var.location
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
    name     = "Standard" # Pay-as-you-go billing
    capacity = 10         # 10,000 Tokens-Per-Minute (TPM)
  }

  model {
    format  = "OpenAI"
    name    = var.chat_model_name
    version = "2024-07-18"
  }
}

#b. Embedding Model Deployment (text-embedding-3-small)
resource "azurerm_cognitive_deployment" "embedding_model" {
  name                 = var.embedding_model_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  sku {
    name     = "Standard" # Pay-as-you-go billing
    capacity = 10         # 10,000 Tokens-Per-Minute (TPM)
  }

  model {
    format  = "OpenAI"
    name    = var.embedding_model_name
    version = "1"
  }
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
