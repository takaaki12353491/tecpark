variable "domain" {
  type = string
}

variable "main_route53_zone_id" {
  type = string
}

variable "alb_id" {
  type = string
}

variable "alb_route53_record_fqdn" {
  type = string
}

variable "front_admin_s3_bucket" {
  type = object({
    id                   = string
    regional_domain_name = string
  })
}

variable "front_admin_cloudfront_origin_access_identity_path" {
  type = string
}
