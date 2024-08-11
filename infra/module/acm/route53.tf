resource "aws_route53_record" "main_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
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
