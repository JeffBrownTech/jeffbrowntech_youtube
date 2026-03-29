variable "name_prefix" {
  description = "Prefix for the generated project name"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}
