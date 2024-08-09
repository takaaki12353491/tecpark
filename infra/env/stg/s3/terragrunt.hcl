include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project = local.common_vars.locals.project

  env       = local.env_vars.locals.env
  sso_roles = local.env_vars.locals.sso_roles
}

terraform {
  source = "${find_in_parent_folders("module")}/s3"
}

inputs = {
  domain = get_env("DOMAIN", "stg.tecpark.net")

  project   = local.project
  env       = local.env
  sso_roles = local.sso_roles
}
