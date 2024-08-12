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
