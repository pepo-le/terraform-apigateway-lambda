output "lambda_helloworld" {
  value = module.apigateway-lambda-helloworld.api_endpoint
}
output "lambda_putitem" {
  value = module.apigateway-lambda-putitem.api_endpoint
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
module "lambda_hello_world" {
  source              = "./modules/lambda"
  function_name       = "lambda_hello_world"
  archive_source_dir  = "./lambda_functions/source/helloworld/"
  archive_output_path = "./lambda_functions/helloworld.zip"
  exec_role_arn       = module.iam_role_exec_lambda.arn
  runtime             = "nodejs20.x"
}

module "lambda_put_item" {
  source              = "./modules/lambda"
  function_name       = "lambda_put_item"
  archive_source_dir  = "./lambda_functions/source/putitem/"
  archive_output_path = "./lambda_functions/putitem.zip"
  exec_role_arn       = module.iam_role_exec_lambda.arn
  runtime             = "nodejs20.x"
}

module "apigateway-lambda-helloworld" {
  source           = "./modules/apigateway-lambda"
  api_name         = "hello-world-api"
  protocol_type    = "HTTP"
  integration_type = "AWS_PROXY"
  lambda_arn       = module.lambda_hello_world.arn
  route_key        = "GET /helloworld"
  description      = "hello world api"
  lambda_name      = module.lambda_hello_world.function_name
  stage_name       = "dev"
}

module "apigateway-lambda-putitem" {
  source           = "./modules/apigateway-lambda"
  api_name         = "put-item-api"
  protocol_type    = "HTTP"
  integration_type = "AWS_PROXY"
  lambda_arn       = module.lambda_put_item.arn
  route_key        = "POST /putitem"
  description      = "put item api"
  lambda_name      = module.lambda_put_item.function_name
  stage_name       = "dev"
}
