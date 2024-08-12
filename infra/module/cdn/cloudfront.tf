resource "aws_cloudfront_distribution" "user" {
  enabled         = true
  is_ipv6_enabled = true
  aliases         = [var.domain]
  price_class     = "PriceClass_200"

  origin {
    origin_id   = var.alb_id
    domain_name = var.alb_route53_record_fqdn

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = var.alb_id
    allowed_methods        = ["GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0

    forwarded_values {
      query_string = true
      headers      = ["*"]
      /* headers = ["Accept", "Accept-Language", "Authorization", "CloudFront-Forwarded-Proto", "Host", "Origin", "Referer", "User-agent"] */

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cloudfront.arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name = "user"
  }
}

resource "aws_cloudfront_distribution" "admin" {
  enabled             = true
  is_ipv6_enabled     = true
  aliases             = ["admin.${var.domain}"]
  price_class         = "PriceClass_200"
  default_root_object = "index.html"

  origin {
    origin_id   = var.front_admin_s3_bucket.id
    domain_name = var.front_admin_s3_bucket.regional_domain_name

    s3_origin_config {
      origin_access_identity = var.front_admin_cloudfront_origin_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = var.front_admin_s3_bucket.id
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 600
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cloudfront.arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name = "admin"
  }
}
