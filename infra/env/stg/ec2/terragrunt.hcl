include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/ec2"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

inputs = {
  availability_zones        = dependency.vpc.outputs.availability_zones
  private_subnet_ids        = dependency.vpc.outputs.private_subnet_ids
  security_group_bastion_id = dependency.vpc.outputs.security_group_bastion_id
}
