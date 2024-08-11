resource "aws_route53_record" "alb" {
  zone_id = var.main_route53_zone_id
  name    = "alb"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
