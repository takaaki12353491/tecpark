resource "aws_s3_bucket" "front_admin" {
  bucket = "${var.project}-${var.env}-front-admin"

  tags = {
    Name = "front-admin"
  }
}

resource "aws_s3_bucket_public_access_block" "front_admin" {
  bucket                  = aws_s3_bucket.front_admin.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "front_admin" {
  bucket = aws_s3_bucket.front_admin.id
  policy = data.aws_iam_policy_document.front_admin.json
}
