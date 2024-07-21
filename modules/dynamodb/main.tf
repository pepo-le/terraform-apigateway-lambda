resource "aws_dynamodb_table" "main" {
  name           = var.table_name
  hash_key       = var.hash_key
  range_key      = var.range_key
  billing_mode   = var.billing_mode
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : 0
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : 0

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
}
