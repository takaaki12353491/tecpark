include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project = local.common_vars.locals.project

  env = local.env_vars.locals.env
}

terraform {
  source = "${find_in_parent_folders("module")}/rds"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

inputs = {
  project = local.project
  env     = local.env

  private_subnet_ids          = dependency.vpc.outputs.private_subnet_ids
  security_group_datastore_id = dependency.vpc.outputs.security_group_datastore_id
}
