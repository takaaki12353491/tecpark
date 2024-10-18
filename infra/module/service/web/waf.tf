resource "aws_wafv2_web_acl" "user" {
  name        = "user"
  description = "Web ACL for ALB to only allow requests with a custom header from CloudFront"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "UserWebACL"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AllowUserCloudfrontSecretHeader"
    priority = 1

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          byte_match_statement {
            search_string         = random_string.user_cloudfront_secret_header.result
            positional_constraint = "EXACTLY"

            field_to_match {
              single_header {
                name = local.user_cloudfront_secret_header
              }
            }

            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowUserCloudfrontSecretHeader"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_association" "user" {
  resource_arn = aws_lb.alb.arn
  web_acl_arn  = aws_wafv2_web_acl.user.arn
}
