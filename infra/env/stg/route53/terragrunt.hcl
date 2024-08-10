include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  domain = local.common_vars.locals.domain
}

terraform {
  source = "${find_in_parent_folders("module")}/route53"
}

dependency "elb" {
  config_path = find_in_parent_folders("elb")
}

dependency "s3" {
  config_path = find_in_parent_folders("s3")
}

inputs = {
  domain = "stg.${local.domain}"

  alb_dns_name = dependency.elb.outputs.alb_dns_name
  alb_zone_id  = dependency.elb.outputs.alb_zone_id

  front_admin_website_domain        = dependency.s3.outputs.front_admin_website_domain
  front_admin_bucket_hosted_zone_id = dependency.s3.outputs.front_admin_bucket_hosted_zone_id
}
