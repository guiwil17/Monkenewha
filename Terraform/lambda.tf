resource "aws_lambda_function" "lambdaAddUser" {
  function_name    = "add_user"
  filename         = "../Lambda/adduser.zip"
  source_code_hash = filebase64sha256("../Lambda/adduser.zip")
  handler          = "dist/index.handler"
  description      = "Permet d'ajouter un utilisateur"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      DYNAMO_DB = var.db
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogUser" {
  name              = "/aws/lambda/adduser"
  retention_in_days = 20
}

resource "aws_lambda_function" "lambdaLogin" {
  function_name    = "login"
  filename         = "../API/Lambda/login.zip"
  source_code_hash = filebase64sha256("../Lambda/login.zip")
  handler          = "dist/index.handler"
  description      = "Permet de se connecter"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.db
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogLogin" {
  name              = "/aws/lambda/login"
  retention_in_days = 365
}


resource "aws_lambda_function" "lambdaLogout" {
  function_name    = "logout"
  filename         = "../Lambda/logout.zip"
  source_code_hash = filebase64sha256("../Lambda/logout.zip")
  handler          = "dist/index.handler"
  description      = "Permet de se déconnecter"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.db
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogLogout" {
  name              = "/aws/lambda/logout"
  retention_in_days = 365
}

