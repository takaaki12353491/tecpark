resource "aws_acm_certificate" "cloudfront" {
  provider = aws.virginia

  domain_name       = "cdn.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
