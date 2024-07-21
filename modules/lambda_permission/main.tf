# Lambda関数の実行許可
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = var.policy_statement_id
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = var.principal
  source_arn    = var.source_arn
}
