# ==========================================
#  Title:  URL shortener in AWS with terraform
#  Author: Harshal Kondke
#  Date:   13 september 2020
# ==========================================

# This will output the API endpoints after deploying the API 
output "Endpoint-url" {
  value       = aws_api_gateway_deployment.prod-api.invoke_url
  description = "API url"
}
