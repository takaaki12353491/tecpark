include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project       = local.common_vars.locals.project
  custom_domain = local.common_vars.locals.custom_domain

  env       = local.env_vars.locals.env
}

terraform {
  source = "${find_in_parent_folders("module")}/front_admin"
}

dependency "route53" {
  config_path = find_in_parent_folders("route53")
}

inputs = {
  project   = local.project
  domain    = "${local.env}.${local.custom_domain}"
  env       = local.env

  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id
}
