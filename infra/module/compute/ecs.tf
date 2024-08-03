resource "aws_ecr_repository" "app" {
  name = "app"

  tags = merge(
    local.common_tags,
    {
      Name = "app"
    }
  )
}
