include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

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
  project   = local.project
  env       = local.env
  app_sg_id = dependency.network.outputs.app_sg_id
}
