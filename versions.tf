# ==========================================
#  Title:  URL shortener in AWS with terraform
#  Author: Harshal Kondke
#  Date:   13 september 2020
# ==========================================

# New versions of terraform or AWS provider can break the code.
# Hence we need to specify the version in this block  
terraform {
  required_version = ">= 0.12.0"

  required_providers {
    aws  = ">= 3.6"
    null = "~> 2.0"
  }
}
