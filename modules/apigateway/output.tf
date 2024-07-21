output "api_id" {
  value = aws_apigatewayv2_api.main.id
}

output "execution_arn" {
  value = aws_apigatewayv2_api.main.execution_arn
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.main.api_endpoint
}
