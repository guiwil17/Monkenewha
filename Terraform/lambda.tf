resource "aws_lambda_function" "lambdaAddUser" {
  function_name    = "add_user"
  filename         = "../API/addUser.zip"
  source_code_hash = filebase64sha256("../API/addUser.zip")
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
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaLogin" {
  function_name    = "login"
  filename         = "../API/login.zip"
  source_code_hash = filebase64sha256("../API/login.zip")
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
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaLogout" {
  function_name    = "logout"
  filename         = "../API/logout.zip"
  source_code_hash = filebase64sha256("../API/logout.zip")
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
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaAddConcert" {
  function_name    = "add_concert"
  filename         = "../API/addConcert.zip"
  source_code_hash = filebase64sha256("../API/addConcert.zip")
  handler          = "dist/index.handler"
  description      = "Permet d'ajouter un concert"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbConcert
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogAddConcert" {
  name              = "/aws/lambda/addConcert"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaEditConcert" {
  function_name    = "edit_concert"
  filename         = "../API/editConcert.zip"
  source_code_hash = filebase64sha256("../API/editConcert.zip")
  handler          = "dist/index.handler"
  description      = "Permet de modifier un concert"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbConcert
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogEditConcert" {
  name              = "/aws/lambda/editConcert"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaGetConcert" {
  function_name    = "get_concert"
  filename         = "../API/getConcert.zip"
  source_code_hash = filebase64sha256("../API/getConcert.zip")
  handler          = "dist/index.handler"
  description      = "Permet de récupérer les concerts"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbConcert
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogGetConcert" {
  name              = "/aws/lambda/getConcert"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaDeleteConcert" {
  function_name    = "delete_concert"
  filename         = "../API/deleteConcert.zip"
  source_code_hash = filebase64sha256("../API/deleteConcert.zip")
  handler          = "dist/index.handler"
  description      = "Permet de supprimer un concert"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbConcert
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogDeleteConcert" {
  name              = "/aws/lambda/deleteConcert"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaAddBlog" {
  function_name    = "add_blog"
  filename         = "../API/addBlog.zip"
  source_code_hash = filebase64sha256("../API/addBlog.zip")
  handler          = "dist/index.handler"
  description      = "Permet d'ajouter un article au blog"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbBlog
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogAddBlog" {
  name              = "/aws/lambda/addBlog"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaEditBlog" {
  function_name    = "edit_blog"
  filename         = "../API/editBlog.zip"
  source_code_hash = filebase64sha256("../API/editBlog.zip")
  handler          = "dist/index.handler"
  description      = "Permet de modifier un article au blog"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbBlog
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogEditBlog" {
  name              = "/aws/lambda/editBlog"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaGetBlog" {
  function_name    = "get_blog"
  filename         = "../API/getBlog.zip"
  source_code_hash = filebase64sha256("../API/getBlog.zip")
  handler          = "dist/index.handler"
  description      = "Permet de récupérer un article au blog"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbBlog
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLoggetBlog" {
  name              = "/aws/lambda/getBlog"
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaDeleteBlog" {
  function_name    = "delete_blog"
  filename         = "../API/deleteBlog.zip"
  source_code_hash = filebase64sha256("../API/deleteBlog.zip")
  handler          = "dist/index.handler"
  description      = "Permet de supprimer un article du blog"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbBlog
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogDeleteBlog" {
  name              = "/aws/lambda/deleteBlog"
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaAddMusique" {
  function_name    = "add_musique"
  filename         = "../API/addMusique.zip"
  source_code_hash = filebase64sha256("../API/addMusique.zip")
  handler          = "dist/index.handler"
  description      = "Permet d'ajouter une musique'"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbMusique
      BUCKET    = var.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogAddMusique" {
  name              = "/aws/lambda/addMusique"
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaEditMusique" {
  function_name    = "edit_musique"
  filename         = "../API/editMusique.zip"
  source_code_hash = filebase64sha256("../API/editMusique.zip")
  handler          = "dist/index.handler"
  description      = "Permet de modifier une musique'"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbMusique
      BUCKET    = var.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogEditMusique" {
  name              = "/aws/lambda/editMusique"
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaGetMusique" {
  function_name    = "get_musique"
  filename         = "../API/getMusique.zip"
  source_code_hash = filebase64sha256("../API/getMusique.zip")
  handler          = "dist/index.handler"
  description      = "Permet de récupérer une musique"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbMusique
      BUCKET    = var.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogGetMusique" {
  name              = "/aws/lambda/getMusique"
  retention_in_days = 60
}

resource "aws_lambda_function" "lambdaListMusique" {
  function_name    = "list_musique"
  filename         = "../API/listMusique.zip"
  source_code_hash = filebase64sha256("../API/listMusique.zip")
  handler          = "dist/index.handler"
  description      = "Permet de lister les musiques"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbMusique
      BUCKET    = var.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogListMusique" {
  name              = "/aws/lambda/listMusique"
  retention_in_days = 60
}


resource "aws_lambda_function" "lambdaDeleteMusique" {
  function_name    = "delete_musique"
  filename         = "../API/deleteMusique.zip"
  source_code_hash = filebase64sha256("../API/deleteMusique.zip")
  handler          = "dist/index.handler"
  description      = "Permet de supprimer une musique"
  runtime          = "nodejs12.x"
  role             = aws_iam_role.lambda_read_role.arn
  timeout          = 800
  environment {
    variables = {
      API_KEY   = var.api_key
      TOKEN_KEY = var.token_key
      DYNAMO_DB = var.dbMusique
      BUCKET    = var.bucket
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdaLogDeleteMusique" {
  name              = "/aws/lambda/deleteMusique"
  retention_in_days = 60
}
