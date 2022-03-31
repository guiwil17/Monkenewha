resource "aws_api_gateway_rest_api" "api" {
  name        = "Monkenewha"
  description = "Permet la gestion du site Monkenewha"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Add User /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "add_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "add_user"
}


resource "aws_api_gateway_method" "add_user" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.add_user.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_add_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.add_user.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaAddUser.invoke_arn

}

resource "aws_api_gateway_method_response" "add_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.add_user.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true

  }
}

resource "aws_api_gateway_integration_response" "lambda_add_user" {
  depends_on  = [aws_api_gateway_integration.lambda_add_user]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.add_user.http_method
  status_code = aws_api_gateway_method_response.add_user.status_code

}


resource "aws_api_gateway_method" "options_method_add_user" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.add_user.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_add_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.options_method_add_user.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_add_user]
}
resource "aws_api_gateway_integration" "options_integration_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.options_method_add_user.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_add_user]
}
resource "aws_api_gateway_integration_response" "options_integration_response_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_user.id
  http_method = aws_api_gateway_method.options_method_add_user.http_method
  status_code = aws_api_gateway_method_response.options_200_add_user.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_add_user]
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Login /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "login"
}


resource "aws_api_gateway_method" "login" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.login.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.login.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaLogin.invoke_arn

}

resource "aws_api_gateway_method_response" "login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.login.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true

  }
}

resource "aws_api_gateway_integration_response" "lambda_login" {
  depends_on  = [aws_api_gateway_integration.lambda_login]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.login.http_method
  status_code = aws_api_gateway_method_response.login.status_code

}


resource "aws_api_gateway_method" "options_method_login" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.options_method_login.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_login]
}
resource "aws_api_gateway_integration" "options_integration_login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.options_method_login.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_login]
}
resource "aws_api_gateway_integration_response" "options_integration_response_login" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.options_method_login.http_method
  status_code = aws_api_gateway_method_response.options_200_login.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_login]
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Logout /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "logout"
}


resource "aws_api_gateway_method" "logout" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.logout.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.logout.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaLogout.invoke_arn

}

resource "aws_api_gateway_method_response" "logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.logout.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true

  }
}

resource "aws_api_gateway_integration_response" "lambda_logout" {
  depends_on  = [aws_api_gateway_integration.lambda_logout]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.logout.http_method
  status_code = aws_api_gateway_method_response.logout.status_code

}


resource "aws_api_gateway_method" "options_method_logout" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.logout.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.options_method_logout.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_logout]
}
resource "aws_api_gateway_integration" "options_integration_logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.options_method_logout.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_logout]
}
resource "aws_api_gateway_integration_response" "options_integration_response_logout" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.logout.id
  http_method = aws_api_gateway_method.options_method_logout.http_method
  status_code = aws_api_gateway_method_response.options_200_logout.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_logout]
}



////////////////////////////////////////////////

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on  = [aws_api_gateway_method.add_user, aws_api_gateway_method.login, aws_api_gateway_method.logout, aws_api_gateway_integration_response.lambda_add_user, aws_api_gateway_integration_response.lambda_login, aws_api_gateway_integration_response.lambda_logout]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

resource "aws_api_gateway_api_key" "Api_Key" {
  name = "Monkenewha_key"
}

resource "aws_api_gateway_usage_plan" "api_usage_plan" {
  name = "Monkenewha_plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_deployment.apideploy.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "api_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.Api_Key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api_usage_plan.id
}

output "base_url" {
  sensitive = true

  value = aws_api_gateway_deployment.apideploy.invoke_url
}

output "API_key" {
  sensitive = true

  value = aws_api_gateway_api_key.Api_Key.value
}
