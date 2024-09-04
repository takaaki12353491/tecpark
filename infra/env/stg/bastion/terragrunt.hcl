include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/operation/bastion"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

inputs = {
  main_vpc_id        = dependency.vpc.outputs.main_vpc_id
  azs                = dependency.vpc.outputs.azs
  private_cidrs      = dependency.vpc.outputs.private_cidrs
  private_subnet_ids = dependency.vpc.outputs.private_subnet_ids
}
