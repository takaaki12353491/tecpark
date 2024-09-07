include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/operation/github"
}

inputs = {
  github_owner = get_env("TF_VAR_terragrunt_github_owner")
}