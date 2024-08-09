data "aws_iam_role" "sso" {
  count = length(var.sso_roles)

  name = var.sso_roles[count.index]
}

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

  statement {
    effect = "Allow"
    actions = [
      "s3:PutBucketPolicy",
      "s3:ListBucket",
      "s3:GetBucketPolicy",
      "s3:DeleteBucketPolicy"
    ]
    resources = ["${aws_s3_bucket.front_admin.arn}"]

    principals {
      type        = "AWS"
      identifiers = data.aws_iam_role.sso[*].arn
    }
  }
}
