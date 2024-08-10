resource "aws_route53_record" "front_admin" {
  zone_id = var.main_route53_zone_id
  name    = "admin"
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.front_admin.website_domain
    zone_id                = aws_s3_bucket.front_admin.hosted_zone_id
    evaluate_target_health = true
  }
}
