resource "aws_dynamodb_table" "default" {
  name           = "url-short"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
  tags = {
    Name        = "url-short"
    Environment = "production"
  }

}
