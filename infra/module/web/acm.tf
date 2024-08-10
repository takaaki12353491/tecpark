resource "aws_acm_certificate" "alb" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name = "alb"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "alb" {
  certificate_arn         = aws_acm_certificate.alb.arn
  validation_record_fqdns = [for record in aws_route53_record.alb_acm_dns_resolve : record.fqdn]
}
