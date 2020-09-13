resource "aws_api_gateway_rest_api" "url-short-api" {
  name        = "url-short-api"
  description = "Url shortener rest API"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "app" {
  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  parent_id   = aws_api_gateway_rest_api.url-short-api.root_resource_id
  path_part   = "app"
}

resource "aws_api_gateway_method" "app-post" {
  rest_api_id   = aws_api_gateway_rest_api.url-short-api.id
  resource_id   = aws_api_gateway_resource.app.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "app-post-ireq" {
  rest_api_id             = aws_api_gateway_rest_api.url-short-api.id
  resource_id             = aws_api_gateway_resource.app.id
  http_method             = aws_api_gateway_method.app-post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:ap-south-1:dynamodb:action/UpdateItem"

  credentials = aws_iam_role.write-role.arn

  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
    {
      "TableName": "url-short",
      "ConditionExpression": "attribute_not_exists(id)",
      "Key": {
        "id": {
          "S": $input.json('$.id')
        }
      },
      "ExpressionAttributeNames": {
        "#u": "url",
        "#ts": "timestamp"
      },
      "ExpressionAttributeValues": {
        ":u": {
          "S": $input.json('$.url')
        },
        ":ts": {
          "S": "$context.requestTime"
        }
      },
      "UpdateExpression": "SET #u = :u, #ts = :ts",
      "ReturnValues": "ALL_NEW"
    }
EOF
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  resource_id = aws_api_gateway_resource.app.id
  http_method = aws_api_gateway_method.app-post.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "app-post-ires" {
  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  resource_id = aws_api_gateway_resource.app.id
  http_method = aws_api_gateway_method.app-post.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = <<EOF
    #set($inputRoot = $input.path('$'))
    {
      "id": "$inputRoot.Attributes.id.S",
      "url": "$inputRoot.Attributes.url.S",
      "timestamp": "$inputRoot.Attributes.timestamp.S",
    }
EOF
  }
}

#------------------------------------------------
# Another method here
#-------------------------------------------------


resource "aws_api_gateway_resource" "id1" {
  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  parent_id   = aws_api_gateway_rest_api.url-short-api.root_resource_id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "id1-post" {
  rest_api_id   = aws_api_gateway_rest_api.url-short-api.id
  resource_id   = aws_api_gateway_resource.id1.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "id1-post-ireq" {
  rest_api_id             = aws_api_gateway_rest_api.url-short-api.id
  resource_id             = aws_api_gateway_resource.id1.id
  http_method             = aws_api_gateway_method.id1-post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:ap-south-1:dynamodb:action/GetItem"

  credentials = aws_iam_role.read-role.arn

  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
    {
  "Key": {
    "id": {
      "S": "$input.params().path.id"
    }
  },
  "TableName": "url-short"
}
EOF
  }
}

resource "aws_api_gateway_method_response" "response_301" {
  rest_api_id         = aws_api_gateway_rest_api.url-short-api.id
  resource_id         = aws_api_gateway_resource.id1.id
  http_method         = aws_api_gateway_method.id1-post.http_method
  status_code         = "301"
  response_parameters = { "method.response.header.Location" = true }
}

resource "aws_api_gateway_integration_response" "id1-post-ires" {
  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  resource_id = aws_api_gateway_resource.id1.id
  http_method = aws_api_gateway_method.id1-post.http_method
  status_code = aws_api_gateway_method_response.response_301.status_code

  response_templates = {
    "application/json" = <<EOF
    #set($inputRoot = $input.path('$'))
#if ($inputRoot.toString().contains("Item"))
  #set($context.responseOverride.header.Location = $inputRoot.Item.url.S)
#end
EOF
  }
}


resource "aws_api_gateway_deployment" "prod-api" {
  depends_on = [aws_api_gateway_integration.id1-post-ireq]

  rest_api_id = aws_api_gateway_rest_api.url-short-api.id
  stage_name  = "prod"
}
