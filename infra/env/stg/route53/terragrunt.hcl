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
  source = "${find_in_parent_folders("module")}/route53"
}

inputs = {
  domain = "${local.env}.${local.custom_domain}"
}
