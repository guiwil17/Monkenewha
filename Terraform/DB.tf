resource "aws_dynamodb_table" "ddbtable" {
  name           = "user"
  hash_key       = "email"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "email"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dbBlog" {
  name           = "blog"
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dbConcert" {
  name           = "concert"
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dbMusique" {
  name           = "musique"
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "id"
    type = "S"
  }
}
