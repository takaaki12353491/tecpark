include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  github_organization = local.common_vars.locals.github_organization
  github_repositories = local.common_vars.locals.github_repositories
}

terraform {
  source = "${find_in_parent_folders("module")}/operation/github"
}

inputs = {
  github_organization = local.github_organization
  github_repositories = local.github_repositories
}
