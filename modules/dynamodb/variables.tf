variable "table_name" {
  description = "DynamoDBのテーブル名"
  type        = string
}

variable "billing_mode" {
  description = "課金モード"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "ハッシュキー"
  type        = string
}

variable "range_key" {
  description = "レンジキー"
  type        = string
}

variable "attributes" {
  description = "属性"
  type = list(object({
    name = string
    type = string
  }))
}

variable "read_capacity" {
  description = "読み取りキャパシティーユニット"
  type        = number
}

variable "write_capacity" {
  description = "書き込みキャパシティーユニット"
  type        = number
}
