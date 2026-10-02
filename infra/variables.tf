variable "location" {
  type        = string
  default     = "indiasouthcentral"
  description = "Location of the resource group."
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
