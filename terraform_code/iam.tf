data "aws_iam_policy_document" "iam-trust-policy-lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam-role-lambda" {
  name               = "iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.iam-trust-policy-lambda.json
}

data "aws_iam_policy_document" "iam-permissions-policy" {
  statement {
    actions = [
      "apigateway:POST",
      "apigateway:DELETE",
      "cloudwatch:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "iam-permissions-policy-attachment-lambda" {
  name   = "iam-policy-lambda"
  role   = aws_iam_role.iam-role-lambda.name
  policy = data.aws_iam_policy_document.iam-permissions-policy.json
}