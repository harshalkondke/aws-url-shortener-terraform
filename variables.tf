# ==========================================
#  Title:  URL shortener in AWS with terraform
#  Author: Harshal Kondke
#  Date:   13 september 2020
# ==========================================

# variable table-name is for dynamodb table
variable "table-name" {
  type        = string
  default     = "url-short"
  description = "Table Name you want to use for dynamoDB"
}

# variable environment is to specify stage of the application
variable "environment" {
  type        = string
  default     = "prod"
  description = "Environment, e.g. 'prod', 'staging', 'dev'"
}
