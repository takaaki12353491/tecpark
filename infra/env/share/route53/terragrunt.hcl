include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  domain = local.common_vars.locals.domain
}

terraform {
  source = "./"
}

inputs = {
  domain = local.domain

  stg_name_servers = [
    "ns-1471.awsdns-55.org.",
    "ns-351.awsdns-43.com.",
    "ns-1936.awsdns-50.co.uk.",
    "ns-667.awsdns-19.net."
  ]
}
