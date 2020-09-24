# ==========================================
#  Title:  URL shortener in AWS with terraform
#  Author: Harshal Kondke
#  Date:   13 september 2020
# ==========================================

# we are not using access_keys and secret_key in arguments for security reasons
# configure your aws cli with your credentials
# that will solve the problem. 
provider "aws" {
  region = "ap-south-1"
}
