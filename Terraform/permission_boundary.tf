data "aws_caller_identity" "current" {
}

data "aws_iam_policy" "permissions_boundary" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/account-management/AccountBoundary"
}

locals {
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/account-management/AccountBoundary"
}
