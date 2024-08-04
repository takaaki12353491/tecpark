include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  tool    = local.common_vars.locals.tool
  project = local.common_vars.locals.project
  env     = local.env_vars.locals.env
}

terraform {
  source = "${find_in_parent_folders("module")}/dns"
}

dependency "network" {
  config_path = find_in_parent_folders("network")
}

inputs = {
  tool    = local.tool
  project = local.project
  env     = local.env

  domain = get_env("DOMAIN", "tecpark.net")

  alb_dns_name = dependency.network.outputs.alb_dns_name
  alb_zone_id  = dependency.network.outputs.alb_zone_id
}
