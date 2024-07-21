variable "function_name" {
  description = "Lambdaの関数名"
  type        = string
}

variable "archive_source_dir" {
  description = "アーカイブするファイルのディレクトリ"
  type        = string
}

variable "archive_output_path" {
  description = "アーカイブしたファイルのパス"
  type        = string
}

variable "exec_role_arn" {
  description = "Lambdaの実行ロールARN"
  type        = string
}

variable "runtime" {
  description = "ランタイム"
  type        = string
}

variable "timeout" {
  description = "タイムアウト時間"
  type        = number
  default     = 3
}
