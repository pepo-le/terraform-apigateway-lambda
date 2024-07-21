resource "aws_apigatewayv2_api" "main" {
  name          = var.api_name
  protocol_type = var.protocol_type
}

resource "aws_apigatewayv2_integration" "main" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = var.integration_type
  integration_uri  = var.integration_uri
}

resource "aws_apigatewayv2_route" "main" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = var.route_key

  target = "integrations/${aws_apigatewayv2_integration.main.id}"
}

resource "aws_apigatewayv2_deployment" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  description = var.description
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_apigatewayv2_route.main]
}

resource "aws_apigatewayv2_stage" "example" {
  api_id        = aws_apigatewayv2_api.main.id
  name          = var.stage_name
  deployment_id = aws_apigatewayv2_deployment.main.id
}

# resource "aws_lambda_permission" "main" {
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
# }
