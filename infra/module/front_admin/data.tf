data "aws_iam_policy_document" "front_admin" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.front_admin.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
