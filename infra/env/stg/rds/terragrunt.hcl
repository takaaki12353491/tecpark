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
  source = "${find_in_parent_folders("module")}/service/rds"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

dependency "api" {
  config_path = find_in_parent_folders("api")
}

dependency "bastion" {
  config_path = find_in_parent_folders("bastion")
}

inputs = {
  project = local.project
  env     = local.env

  main_vpc_id        = dependency.vpc.outputs.main_vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnet_ids

  api_security_group_id = dependency.api.outputs.api_security_group_id

  bastion_security_group_id = dependency.bastion.outputs.bastion_security_group_id
}
