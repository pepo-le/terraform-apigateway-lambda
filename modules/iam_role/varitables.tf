variable "role_name" {
  description = "IAMロールの名前"
  type        = string
}

variable "assume_role_policy" {
  description = "AssumeRoleポリシーのJSONドキュメント"
  type        = string
}
