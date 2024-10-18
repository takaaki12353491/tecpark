resource "github_actions_environment_variable" "aws_private_subnet" {
  for_each = aws_subnet.private

  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_PRIVATE_SUBNET_${upper(replace(each.key, "/[^a-zA-Z0-9_]/", "_"))}"
  value         = each.value.id
}
