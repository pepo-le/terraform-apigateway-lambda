data "archive_file" "main" {
  type        = "zip"
  source_dir  = var.archive_source_dir
  output_path = var.archive_output_path
}

resource "aws_lambda_function" "main" {
  function_name = var.function_name
  role          = var.exec_role_arn
  handler       = "index.handler"
  runtime       = var.runtime
  timeout       = var.timeout

  filename = var.archive_output_path
}
