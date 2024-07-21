output "lambda_helloworld" {
  value = module.apigateway_helloworld.api_endpoint
}
output "lambda_putitem" {
  value = module.apigateway_putitem.api_endpoint
}
module "iam_role_exec_lambda" {
  source    = "./modules/iam_role"
  role_name = "foo-dev-task-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}
module "iam_role_policy_attachment_lambda" {
  source     = "./modules/iam_role_policy_attachment"
  role_name  = module.iam_role_exec_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
module "iam_role_policy_attachment_lambda_dynamodb" {
  source     = "./modules/iam_role_policy_attachment"
  role_name  = module.iam_role_exec_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}
module "dynamodb_table" {
  source         = "./modules/dynamodb"
  table_name     = "foo-table"
  hash_key       = "id"
  range_key      = "timestamp"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 1
  write_capacity = 1


  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "timestamp"
      type = "N"
    },
  ]
}
module "lambda_helloworld" {
  source              = "./modules/lambda"
  function_name       = "lambda_helloworld"
  archive_source_dir  = "./lambda_functions/source/helloworld/"
  archive_output_path = "./lambda_functions/helloworld.zip"
  exec_role_arn       = module.iam_role_exec_lambda.arn
  runtime             = "nodejs20.x"
}

module "lambda_putitem" {
  source              = "./modules/lambda"
  function_name       = "lambda_putitem"
  archive_source_dir  = "./lambda_functions/source/putitem/"
  archive_output_path = "./lambda_functions/putitem.zip"
  exec_role_arn       = module.iam_role_exec_lambda.arn
  runtime             = "nodejs20.x"
}

module "apigateway_helloworld" {
  source           = "./modules/apigateway"
  api_name         = "helloworld-api"
  protocol_type    = "HTTP"
  integration_type = "AWS_PROXY"
  integration_uri  = module.lambda_helloworld.arn
  route_key        = "GET /helloworld"
  description      = "hello world api"
  stage_name       = "dev"
}

module "apigateway_putitem" {
  source           = "./modules/apigateway"
  api_name         = "putitem-api"
  protocol_type    = "HTTP"
  integration_type = "AWS_PROXY"
  integration_uri  = module.lambda_putitem.arn
  route_key        = "POST /putitem"
  description      = "put item api"
  stage_name       = "dev"
}

module "lambda_permission_helloworld" {
  source               = "./modules/lambda_permission"
  policy_statement_id  = "AllowExecutionFromAPIGatewayHelloworld"
  lambda_function_name = module.lambda_helloworld.function_name
  principal            = "apigateway.amazonaws.com"
  source_arn           = "${module.apigateway_helloworld.execution_arn}/*/*"
}

module "lambda_permission_putitem" {
  source               = "./modules/lambda_permission"
  policy_statement_id  = "AllowExecutionFromAPIGatewayPutItem"
  lambda_function_name = module.lambda_putitem.function_name
  principal            = "apigateway.amazonaws.com"
  source_arn           = "${module.apigateway_putitem.execution_arn}/*/*"
}
