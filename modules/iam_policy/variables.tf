variable "policy_name" {
  description = "IAMポリシーの名前"
  type        = string
}

variable "policy_description" {
  description = "IAMポリシーの説明"
  type        = string
}

variable "policy" {
  description = "IAMポリシーのJSONドキュメント"
  type        = string
}
