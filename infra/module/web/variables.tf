variable "domain" {
  type = string
}

variable "main_vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = map(string)
}

variable "main_route53_zone_id" {
  type = string
}
