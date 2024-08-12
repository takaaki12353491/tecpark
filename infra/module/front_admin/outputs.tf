output "front_admin_s3_bucket" {
  value = {
    id                   = aws_s3_bucket.front_admin.id
    regional_domain_name = aws_s3_bucket.front_admin.bucket_regional_domain_name
  }
}

output "front_admin_cloudfront_origin_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.front_admin.cloudfront_access_identity_path
}
