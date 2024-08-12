output "main_acm_certificate_arn" {
  value = aws_acm_certificate.main.arn
}

output "cloudfront_acm_certificate_arn" {
  value = aws_acm_certificate.cloudfront.arn
}
