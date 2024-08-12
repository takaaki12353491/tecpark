variable "domain" {
  type = string
}

variable "main_vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = map(string)
}

variable "dummy_subnet_id" {
  type = string
}

variable "main_route53_zone_id" {
  type = string
}

variable "main_acm_certificate_arn" {
  type = string
}

variable "cloudfront_acm_certificate_arn" {
  type = string
}
