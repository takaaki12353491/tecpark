include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  az_suffixes = local.env_vars.locals.az_suffixes
}

terraform {
  source = "${find_in_parent_folders("module")}/common/vpc"
}

inputs = {
  az_suffixes = local.az_suffixes
}
