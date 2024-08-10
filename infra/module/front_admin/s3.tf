resource "aws_s3_bucket" "front_admin" {
  # 静的ウェブサイトとしてホスティングする場合はバケット名をドメイン名を一致させる必要がある
  bucket = "admin.${var.domain}"

  tags = {
    Name = "front-admin"
  }
}

resource "aws_s3_bucket_website_configuration" "front_admin" {
  bucket = aws_s3_bucket.front_admin.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "front_admin" {
  bucket                  = aws_s3_bucket.front_admin.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "front_admin" {
  bucket = aws_s3_bucket.front_admin.id
  policy = data.aws_iam_policy_document.front_admin.json

  depends_on = [aws_s3_bucket_public_access_block.front_admin]
}
