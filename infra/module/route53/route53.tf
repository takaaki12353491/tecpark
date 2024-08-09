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

resource "aws_route53_record" "front_admin" {
  zone_id = aws_route53_zone.main.id
  name    = "admin"
  type    = "A"

  alias {
    name                   = var.front_admin_website_domain
    zone_id                = var.front_admin_bucket_hosted_zone_id
    evaluate_target_health = true
  }
}
