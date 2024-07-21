variable "api_name" {
  description = "API Gatewayの名前"
  type        = string
}

variable "protocol_type" {
  description = "プロトコルタイプ"
  type        = string
  default     = "HTTP"
}

variable "integration_type" {
  description = "統合タイプ"
  type        = string
  default     = "AWS_PROXY"
}

variable "route_key" {
  description = "ルートキー"
  type        = string
}

variable "description" {
  description = "デプロイメントの説明"
  type        = string
}

variable "stage_name" {
  description = "ステージ名"
  type        = string
}

variable "lambda_arn" {
  description = "LambdaのARN"
  type        = string
}

variable "lambda_name" {
  description = "Lambdaの名前"
  type        = string
}
