variable "policy_statement_id" {
  description = "ポリシーステートメントID"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda関数の名前"
  type        = string
}

variable "principal" {
  description = "プリンシパル"
  type        = string
}

variable "source_arn" {
  description = "ソースARN"
  type        = string
}
