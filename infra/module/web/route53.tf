resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.id
  name    = "api"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
