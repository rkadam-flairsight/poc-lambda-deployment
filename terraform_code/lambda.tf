# zip the lambda code based on all files present in deployment-artefact directory

data "archive_file" "archive-lambda-functions" {
  for_each    = local.lambda-functions
  type        = "zip"
  source_file = each.value
  output_path = "./${each.key}.zip"
}

resource "aws_lambda_function" "lambda-functions" {
  for_each         = data.archive_file.archive-lambda-functions
  function_name    = each.key
  filename         = each.value.output_path
  source_code_hash = filebase64sha256(each.value.output_path)
  handler          = "${each.key}.main"
  role             = aws_iam_role.iam-role-lambda.arn
  runtime          = "python3.8"
  memory_size      = 256
  timeout          = 15

#   environment {
#     variables = local.lambda-environment-variables
#   }

#   layers = []

#   vpc_config {
#     subnet_ids = []
#     security_group_ids = []
#   }

  tags = {
    Name = each.key
  }
}