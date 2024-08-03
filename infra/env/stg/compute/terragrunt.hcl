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
  source = "${find_in_parent_folders("module")}/compute"
}

dependency "network" {
  config_path = find_in_parent_folders("network")
}

inputs = {
  tool                      = local.tool
  project                   = local.project
  env                       = local.env
  public_subnet_ids         = dependency.network.outputs.public_subnet_ids
  private_subnet_ids        = dependency.network.outputs.private_subnet_ids
  security_group_app_id     = dependency.network.outputs.security_group_app_id
  security_group_bastion_id = dependency.network.outputs.security_group_bastion_id
}
