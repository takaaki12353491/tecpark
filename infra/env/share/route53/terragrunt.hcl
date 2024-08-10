include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  custom_domain = local.common_vars.locals.custom_domain
}

terraform {
  source = "./"
}

inputs = {
  domain = local.custom_domain

  stg_name_servers = split(",", get_env("STG_NAME_SERVERS"))
}
