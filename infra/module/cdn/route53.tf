resource "aws_route53_record" "cloudfront_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.main_route53_zone_id
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = "300"
}

resource "aws_route53_record" "main" {
  zone_id = var.main_route53_zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.user.domain_name
    zone_id                = aws_cloudfront_distribution.user.hosted_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "cloudfront" {
  zone_id = var.main_route53_zone_id
  name    = "admin"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.admin.domain_name
    zone_id                = aws_cloudfront_distribution.admin.hosted_zone_id
    evaluate_target_health = true
  }
}
