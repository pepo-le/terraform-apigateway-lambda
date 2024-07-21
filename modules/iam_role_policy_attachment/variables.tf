variable "role_name" {
  description = "ロールの名前"
  type        = string
}

variable "policy_arn" {
  description = "アタッチするIAMポリシーのARN"
  type        = string
}
