resource "aws_ecr_repository" "api" {
  name = "api"

  tags = merge(
    local.common_tags,
    {
      Name = "api"
    }
  )
}
