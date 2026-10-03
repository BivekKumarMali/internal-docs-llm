variable "location" {
  type        = string
  default     = "southindia"
  description = "Location for most resources (resource group, storage, search). Azure OpenAI uses a separate variable (openai_location) since it's only available in a narrower set of regions — see openai_location below."
}

variable "openai_location" {
  type        = string
  default     = "eastus"
  description = "Azure OpenAI is not available in every region Cognitive Services generally supports. No India region currently supports it, so this is deliberately separate from var.location. eastus is one of the most reliably available regions for new Azure OpenAI deployments."
}

variable "app_name" {
  type        = string
  default     = "internal-docs-llm"
  description = "Name of the application."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev, staging, prod). Used for tagging."
}

variable "chat_model_name" {
  type        = string
  default     = "gpt-4o-mini"
  description = "Name of the chat model."
}

variable "embedding_model_name" {
  type        = string
  default     = "text-embedding-3-small"
  description = "Name of the embedding model."
}
