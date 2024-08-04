resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      Name = "main"
    }
  )
}
