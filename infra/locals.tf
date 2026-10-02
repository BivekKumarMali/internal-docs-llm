locals {
  resource-gp-name                = "${var.app_name}-rg"
  openai-name                     = "${var.app_name}-openai"
  search_service_name             = "${var.app_name}-search"
  model-deployment-chat-name      = "${var.app_name}-chat"
  model-deployment-embedding-name = "${var.app_name}-text-embedding"
  storage_account_name            = "storage"

  common_tags = {
    project     = var.app_name
    environment = var.environment
    managed_by  = "terraform"
  }
}
