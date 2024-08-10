resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name = "main"
  }
}
