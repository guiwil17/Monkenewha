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
