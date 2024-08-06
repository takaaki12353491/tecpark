resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name = "main"
  }
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.id
  name    = "api"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
