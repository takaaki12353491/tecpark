resource "aws_ecr_repository" "app" {
  name = "app"

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "app"
    }
  )
}
