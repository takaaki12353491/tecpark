resource "aws_route53_zone" "main" {
  name          = local.domain
  force_destroy = false

  tags = {
    Name = "main"
  }
}
