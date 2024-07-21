output "name" {
  description = "IAMロールの名前"
  value       = aws_iam_role.main.name
}

output "arn" {
  description = "IAMロールのARN"
  value       = aws_iam_role.main.arn
}
