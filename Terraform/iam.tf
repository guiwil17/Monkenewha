data "aws_iam_policy_document" "lambdarole" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "apigateway.amazonaws.com", "s3.amazonaws.com"]
    }
    effect = "Allow"
    sid    = ""
  }
}

#role for read lambda
resource "aws_iam_role" "lambda_read_role" {
  name               = "Monkenewha_role"
  assume_role_policy = data.aws_iam_policy_document.lambdarole.json
}

data "aws_iam_policy_document" "lambda_read" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction",
      "lambda:InvokeAsync"
    ]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["*"]
  }

  statement {
    sid       = "SpecificTable"
    effect    = "Allow"
    actions   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:UpdateItem", "dynamodb:Scan"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda_read" {
  name   = "API_role_policy"
  role   = aws_iam_role.lambda_read_role.id
  policy = data.aws_iam_policy_document.lambda_read.json
}

#permission for api gateway to invoke lambda

resource "aws_lambda_permission" "api_add_user" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaAddUser.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}


resource "aws_lambda_permission" "api_login" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaLogin.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_logout" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaLogout.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_addConcert" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaAddConcert.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_editConcert" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaEditConcert.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_deleteConcert" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaDeleteConcert.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_getConcert" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaGetConcert.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_getBlog" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaGetBlog.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_addBlog" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaAddBlog.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_editBlog" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaEditBlog.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_deleteBlog" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaDeleteBlog.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}


resource "aws_lambda_permission" "api_deleteMusique" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaDeleteMusique.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_addMusique" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaAddMusique.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}


resource "aws_lambda_permission" "api_editMusique" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaEditMusique.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_listMusique" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaListMusique.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "api_getMusique" {
  statement_id  = "AllowExecutionReadFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambdaGetMusique.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}
