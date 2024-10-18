resource "random_string" "user_cloudfront_secret_header" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "user_cloudfront_secret_header" {
  name = local.user_cloudfront_secret_header
}

resource "aws_secretsmanager_secret_version" "user_cloudfront_secret_header" {
  secret_id     = aws_secretsmanager_secret.user_cloudfront_secret_header.id
  secret_string = random_string.user_cloudfront_secret_header.result
}
