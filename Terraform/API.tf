resource "aws_api_gateway_rest_api" "api" {
  name        = "Monkenewha"
  description = "Permet la gestion du site Monkenewha"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  User /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "user"
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Add User /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "add_user" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.user.id
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
//////  Concert /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "concert"
}

resource "aws_api_gateway_resource" "getConcert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.concert.id
  path_part   = "getConcert"
}

resource "aws_api_gateway_method" "getConcert" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.getConcert.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_getConcert" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.getConcert.id
  http_method             = aws_api_gateway_method.getConcert.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaGetConcert.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "getConcert_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getConcert.id
  http_method = aws_api_gateway_method.getConcert.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_getConcert]
}

resource "aws_api_gateway_method_response" "getConcert_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getConcert.id
  http_method = aws_api_gateway_method.getConcert.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.getConcert]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_getConcert" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.getConcert.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_getConcert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getConcert.id
  http_method = aws_api_gateway_method.options_method_getConcert.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_getConcert]
}
resource "aws_api_gateway_integration" "options_integration_getConcert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getConcert.id
  http_method = aws_api_gateway_method.options_method_getConcert.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_getConcert]
}
resource "aws_api_gateway_integration_response" "options_integration_response_getConcert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getConcert.id
  http_method = aws_api_gateway_method.options_method_getConcert.http_method
  status_code = aws_api_gateway_method_response.options_200_getConcert.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_getConcert]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Add Concert /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.concert.id
  path_part   = "add_concert"
}


resource "aws_api_gateway_method" "add_concert" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.add_concert.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.add_concert.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaAddConcert.invoke_arn

}

resource "aws_api_gateway_method_response" "add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.add_concert.http_method
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

resource "aws_api_gateway_integration_response" "lambda_add_concert" {
  depends_on  = [aws_api_gateway_integration.lambda_add_concert]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.add_concert.http_method
  status_code = aws_api_gateway_method_response.add_concert.status_code

}


resource "aws_api_gateway_method" "options_method_add_concert" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.add_concert.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.options_method_add_concert.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_add_concert]
}
resource "aws_api_gateway_integration" "options_integration_add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.options_method_add_concert.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_add_concert]
}
resource "aws_api_gateway_integration_response" "options_integration_response_add_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_concert.id
  http_method = aws_api_gateway_method.options_method_add_concert.http_method
  status_code = aws_api_gateway_method_response.options_200_add_concert.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_add_concert]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Delete Concert /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "delete_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.concert.id
  path_part   = "delete_concert"
}

resource "aws_api_gateway_method" "delete_concert" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.delete_concert.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_delete_concert" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.delete_concert.id
  http_method             = aws_api_gateway_method.delete_concert.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaDeleteConcert.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.id" = "method.request.querystring.id"
  # }
  request_templates = {
    "application/json" = <<EOF
    {"id":  "$input.params('id')",
    "test":  "$input.params('test')"
    }
    EOF  
  }
}

resource "aws_api_gateway_integration_response" "delete_concert_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_concert.id
  http_method = aws_api_gateway_method.delete_concert.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_delete_concert]
}

resource "aws_api_gateway_method_response" "delete_concert_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_concert.id
  http_method = aws_api_gateway_method.delete_concert.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.delete_concert]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_delete_concert" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.delete_concert.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_delete_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_concert.id
  http_method = aws_api_gateway_method.options_method_delete_concert.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_delete_concert]
}
resource "aws_api_gateway_integration" "options_integration_delete_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_concert.id
  http_method = aws_api_gateway_method.options_method_delete_concert.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_delete_concert]
}
resource "aws_api_gateway_integration_response" "options_integration_response_delete_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_concert.id
  http_method = aws_api_gateway_method.options_method_delete_concert.http_method
  status_code = aws_api_gateway_method_response.options_200_delete_concert.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_delete_concert]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Edit Concert /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.concert.id
  path_part   = "edit_concert"
}


resource "aws_api_gateway_method" "edit_concert" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.edit_concert.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.edit_concert.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaEditConcert.invoke_arn

}

resource "aws_api_gateway_method_response" "edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.edit_concert.http_method
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

resource "aws_api_gateway_integration_response" "lambda_edit_concert" {
  depends_on  = [aws_api_gateway_integration.lambda_edit_concert]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.edit_concert.http_method
  status_code = aws_api_gateway_method_response.edit_concert.status_code

}


resource "aws_api_gateway_method" "options_method_edit_concert" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.edit_concert.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.options_method_edit_concert.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_edit_concert]
}
resource "aws_api_gateway_integration" "options_integration_edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.options_method_edit_concert.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_edit_concert]
}
resource "aws_api_gateway_integration_response" "options_integration_response_edit_concert" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_concert.id
  http_method = aws_api_gateway_method.options_method_edit_concert.http_method
  status_code = aws_api_gateway_method_response.options_200_edit_concert.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_edit_concert]
}

/////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Blog /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "blog"
}

resource "aws_api_gateway_resource" "getBlog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.blog.id
  path_part   = "getBlog"
}

resource "aws_api_gateway_method" "getBlog" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.getBlog.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_getBlog" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.getBlog.id
  http_method             = aws_api_gateway_method.getBlog.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaGetBlog.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "getBlog_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getBlog.id
  http_method = aws_api_gateway_method.getBlog.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_getBlog]
}

resource "aws_api_gateway_method_response" "getBlog_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getBlog.id
  http_method = aws_api_gateway_method.getBlog.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.getBlog]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_getBlog" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.getBlog.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_getBlog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getBlog.id
  http_method = aws_api_gateway_method.options_method_getBlog.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_getBlog]
}
resource "aws_api_gateway_integration" "options_integration_getBlog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getBlog.id
  http_method = aws_api_gateway_method.options_method_getBlog.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_getBlog]
}
resource "aws_api_gateway_integration_response" "options_integration_response_getBlog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getBlog.id
  http_method = aws_api_gateway_method.options_method_getBlog.http_method
  status_code = aws_api_gateway_method_response.options_200_getBlog.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_getBlog]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Add Blog /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.blog.id
  path_part   = "add_blog"
}


resource "aws_api_gateway_method" "add_blog" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.add_blog.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.add_blog.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaAddBlog.invoke_arn

}

resource "aws_api_gateway_method_response" "add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.add_blog.http_method
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

resource "aws_api_gateway_integration_response" "lambda_add_blog" {
  depends_on  = [aws_api_gateway_integration.lambda_add_blog]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.add_blog.http_method
  status_code = aws_api_gateway_method_response.add_blog.status_code

}


resource "aws_api_gateway_method" "options_method_add_blog" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.add_blog.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.options_method_add_blog.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_add_blog]
}
resource "aws_api_gateway_integration" "options_integration_add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.options_method_add_blog.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_add_blog]
}
resource "aws_api_gateway_integration_response" "options_integration_response_add_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_blog.id
  http_method = aws_api_gateway_method.options_method_add_blog.http_method
  status_code = aws_api_gateway_method_response.options_200_add_blog.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_add_blog]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Delete Blog /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "delete_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.blog.id
  path_part   = "delete_blog"
}

resource "aws_api_gateway_method" "delete_blog" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.delete_blog.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_delete_blog" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.delete_blog.id
  http_method             = aws_api_gateway_method.delete_blog.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaDeleteBlog.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = <<EOF
    {"id":  "$input.params('id')"}
    EOF  
  }
}

resource "aws_api_gateway_integration_response" "delete_blog_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_blog.id
  http_method = aws_api_gateway_method.delete_blog.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_delete_blog]
}

resource "aws_api_gateway_method_response" "delete_blog_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_blog.id
  http_method = aws_api_gateway_method.delete_blog.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.delete_blog]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_delete_blog" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.delete_blog.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_delete_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_blog.id
  http_method = aws_api_gateway_method.options_method_delete_blog.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_delete_blog]
}
resource "aws_api_gateway_integration" "options_integration_delete_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_blog.id
  http_method = aws_api_gateway_method.options_method_delete_blog.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_delete_blog]
}
resource "aws_api_gateway_integration_response" "options_integration_response_delete_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_blog.id
  http_method = aws_api_gateway_method.options_method_delete_blog.http_method
  status_code = aws_api_gateway_method_response.options_200_delete_blog.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_delete_blog]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Edit Blog /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.blog.id
  path_part   = "edit_blog"
}


resource "aws_api_gateway_method" "edit_blog" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.edit_blog.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.edit_blog.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaEditBlog.invoke_arn

}

resource "aws_api_gateway_method_response" "edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.edit_blog.http_method
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

resource "aws_api_gateway_integration_response" "lambda_edit_blog" {
  depends_on  = [aws_api_gateway_integration.lambda_edit_blog]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.edit_blog.http_method
  status_code = aws_api_gateway_method_response.edit_blog.status_code

}


resource "aws_api_gateway_method" "options_method_edit_blog" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.edit_blog.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.options_method_edit_blog.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_edit_blog]
}
resource "aws_api_gateway_integration" "options_integration_edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.options_method_edit_blog.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_edit_blog]
}
resource "aws_api_gateway_integration_response" "options_integration_response_edit_blog" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_blog.id
  http_method = aws_api_gateway_method.options_method_edit_blog.http_method
  status_code = aws_api_gateway_method_response.options_200_edit_blog.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_edit_blog]
}

########

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Musique /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "musique"
}

resource "aws_api_gateway_resource" "getMusique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.musique.id
  path_part   = "getMusique"
}

resource "aws_api_gateway_method" "getMusique" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.getMusique.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_getMusique" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.getMusique.id
  http_method             = aws_api_gateway_method.getMusique.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaGetMusique.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = <<EOF
    {"key":  "$input.params('key')"}
    EOF  
  }
}

resource "aws_api_gateway_integration_response" "getMusique_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getMusique.id
  http_method = aws_api_gateway_method.getMusique.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_getMusique]
}

resource "aws_api_gateway_method_response" "getMusique_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getMusique.id
  http_method = aws_api_gateway_method.getMusique.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.getMusique]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_getMusique" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.getMusique.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_getMusique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getMusique.id
  http_method = aws_api_gateway_method.options_method_getMusique.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_getMusique]
}
resource "aws_api_gateway_integration" "options_integration_getMusique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getMusique.id
  http_method = aws_api_gateway_method.options_method_getMusique.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_getMusique]
}
resource "aws_api_gateway_integration_response" "options_integration_response_getMusique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.getMusique.id
  http_method = aws_api_gateway_method.options_method_getMusique.http_method
  status_code = aws_api_gateway_method_response.options_200_getMusique.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_getMusique]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Add Musique /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.musique.id
  path_part   = "add_musique"
}


resource "aws_api_gateway_method" "add_musique" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.add_musique.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.add_musique.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaAddMusique.invoke_arn

}

resource "aws_api_gateway_method_response" "add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.add_musique.http_method
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

resource "aws_api_gateway_integration_response" "lambda_add_musique" {
  depends_on  = [aws_api_gateway_integration.lambda_add_musique]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.add_musique.http_method
  status_code = aws_api_gateway_method_response.add_musique.status_code

}


resource "aws_api_gateway_method" "options_method_add_musique" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.add_musique.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.options_method_add_musique.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_add_musique]
}
resource "aws_api_gateway_integration" "options_integration_add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.options_method_add_musique.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_add_musique]
}
resource "aws_api_gateway_integration_response" "options_integration_response_add_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.add_musique.id
  http_method = aws_api_gateway_method.options_method_add_musique.http_method
  status_code = aws_api_gateway_method_response.options_200_add_musique.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_add_musique]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Delete Musique /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "delete_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.musique.id
  path_part   = "delete_musique"
}

resource "aws_api_gateway_method" "delete_musique" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.delete_musique.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_delete_musique" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.delete_musique.id
  http_method             = aws_api_gateway_method.delete_musique.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaDeleteMusique.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = <<EOF
    {"id":  "$input.params('id')"}
    EOF  
  }
}

resource "aws_api_gateway_integration_response" "delete_musique_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_musique.id
  http_method = aws_api_gateway_method.delete_musique.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_delete_musique]
}

resource "aws_api_gateway_method_response" "delete_musique_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_musique.id
  http_method = aws_api_gateway_method.delete_musique.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.delete_musique]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_delete_musique" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.delete_musique.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_delete_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_musique.id
  http_method = aws_api_gateway_method.options_method_delete_musique.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_delete_musique]
}
resource "aws_api_gateway_integration" "options_integration_delete_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_musique.id
  http_method = aws_api_gateway_method.options_method_delete_musique.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_delete_musique]
}
resource "aws_api_gateway_integration_response" "options_integration_response_delete_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.delete_musique.id
  http_method = aws_api_gateway_method.options_method_delete_musique.http_method
  status_code = aws_api_gateway_method_response.options_200_delete_musique.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_delete_musique]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  Edit Musique /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.musique.id
  path_part   = "edit_musique"
}


resource "aws_api_gateway_method" "edit_musique" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.edit_musique.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

}


resource "aws_api_gateway_integration" "lambda_edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.edit_musique.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambdaEditMusique.invoke_arn

}

resource "aws_api_gateway_method_response" "edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.edit_musique.http_method
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

resource "aws_api_gateway_integration_response" "lambda_edit_musique" {
  depends_on  = [aws_api_gateway_integration.lambda_edit_musique]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.edit_musique.http_method
  status_code = aws_api_gateway_method_response.edit_musique.status_code

}


resource "aws_api_gateway_method" "options_method_edit_musique" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.edit_musique.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.options_method_edit_musique.http_method
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.options_method_edit_musique]
}
resource "aws_api_gateway_integration" "options_integration_edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.options_method_edit_musique.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_edit_musique]
}
resource "aws_api_gateway_integration_response" "options_integration_response_edit_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.edit_musique.id
  http_method = aws_api_gateway_method.options_method_edit_musique.http_method
  status_code = aws_api_gateway_method_response.options_200_edit_musique.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_edit_musique]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////  List Musique /////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_api_gateway_resource" "list_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.musique.id
  path_part   = "list_musique"
}

resource "aws_api_gateway_method" "list_musique" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.list_musique.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "resource_integration_list_musique" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.list_musique.id
  http_method             = aws_api_gateway_method.list_musique.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambdaListMusique.invoke_arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"

  # request_parameters = {
  #   "integration.request.querystring.date" = "method.request.querystring.date"
  # }
  request_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "list_musique_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.list_musique.id
  http_method = aws_api_gateway_method.list_musique.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.resource_integration_list_musique]
}

resource "aws_api_gateway_method_response" "list_musique_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.list_musique.id
  http_method = aws_api_gateway_method.list_musique.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.list_musique]
}

// Mise en place d'une méthode option qui va se charger de mettre l'entête pour les CORS

resource "aws_api_gateway_method" "options_method_list_musique" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.list_musique.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_list_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.list_musique.id
  http_method = aws_api_gateway_method.options_method_list_musique.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.options_method_list_musique]
}
resource "aws_api_gateway_integration" "options_integration_list_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.list_musique.id
  http_method = aws_api_gateway_method.options_method_list_musique.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
  depends_on = [aws_api_gateway_method.options_method_list_musique]
}
resource "aws_api_gateway_integration_response" "options_integration_response_list_musique" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.list_musique.id
  http_method = aws_api_gateway_method.options_method_list_musique.http_method
  status_code = aws_api_gateway_method_response.options_200_list_musique.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200_list_musique]
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
  depends_on = [
    aws_api_gateway_method.add_user,
    aws_api_gateway_method.login,
    aws_api_gateway_method.logout,
    aws_api_gateway_method.add_concert,
    aws_api_gateway_method.edit_concert,
    aws_api_gateway_method.delete_concert,
    aws_api_gateway_method.getConcert,
    aws_api_gateway_method.add_blog,
    aws_api_gateway_method.edit_blog,
    aws_api_gateway_method.delete_blog,
    aws_api_gateway_method.getBlog,
    aws_api_gateway_method.add_musique,
    aws_api_gateway_method.edit_musique,
    aws_api_gateway_method.getMusique,
    aws_api_gateway_method.list_musique,
    aws_api_gateway_method.delete_musique,
    aws_api_gateway_integration_response.lambda_add_user,
    aws_api_gateway_integration_response.lambda_login,
    aws_api_gateway_integration_response.lambda_logout,
    aws_api_gateway_integration_response.lambda_add_blog,
    aws_api_gateway_integration_response.lambda_edit_blog,
    aws_api_gateway_integration_response.lambda_add_concert,
    aws_api_gateway_integration_response.lambda_edit_concert,
    aws_api_gateway_integration_response.lambda_add_musique,
    aws_api_gateway_integration_response.lambda_edit_musique
  ]
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
