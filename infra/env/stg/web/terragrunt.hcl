include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  custom_domain = local.common_vars.locals.custom_domain

  env = local.env_vars.locals.env
}

terraform {
  source = "${find_in_parent_folders("module")}/web"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

dependency "route53" {
  config_path = find_in_parent_folders("route53")
}

dependency "acm" {
  config_path = find_in_parent_folders("acm")
}

inputs = {
  domain = "${local.env}.${local.custom_domain}"

  main_vpc_id       = dependency.vpc.outputs.main_vpc_id
  public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
  dummy_subnet_id   = dependency.vpc.outputs.dummy_subnet_id

  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id

  main_acm_certificate_arn       = dependency.acm.outputs.main_acm_certificate_arn
  cloudfront_acm_certificate_arn = dependency.acm.outputs.cloudfront_acm_certificate_arn
}
