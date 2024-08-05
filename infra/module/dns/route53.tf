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

resource "aws_route53_record" "name" {
  zone_id = aws_route53_zone.main.id
  name    = ""
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
