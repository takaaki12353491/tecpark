resource "aws_route53_record" "api" {
  zone_id = var.main_route53_zone_id
  name    = "api"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "alb_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.alb.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = var.main_route53_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 600
  records         = [each.value.record]
}
