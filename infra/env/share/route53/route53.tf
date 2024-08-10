resource "aws_route53_zone" "main" {
  name = var.domain

  tags = {
    Name = "main"
  }
}

resource "aws_route53_record" "stg" {
  allow_overwrite = true
  zone_id         = aws_route53_zone.main.id
  name            = "stg.${var.domain}"
  type            = "NS"
  records         = var.stg_name_servers
  ttl             = 300
}
