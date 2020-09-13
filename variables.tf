variable "table-name" {
  type        = string
  default     = "url-short"
  description = "Table Name you want to use for dynamoDB"
}
variable "environment" {
  type        = string
  default     = "prod"
  description = "Environment, e.g. 'prod', 'staging', 'dev'"
}
