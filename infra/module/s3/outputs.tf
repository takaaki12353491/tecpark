output "front_admin_website_domain" {
  value = aws_s3_bucket_website_configuration.front_admin.website_domain
}

output "front_admin_bucket_hosted_zone_id" {
  value = aws_s3_bucket.front_admin.hosted_zone_id
}
