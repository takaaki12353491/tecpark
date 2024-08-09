include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/elb"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

inputs = {
  vpc_main_id           = dependency.vpc.outputs.vpc_main_id
  public_subnet_ids     = dependency.vpc.outputs.public_subnet_ids
  dummy_subnet_id       = dependency.vpc.outputs.dummy_subnet_id
  security_group_web_id = dependency.vpc.outputs.security_group_web_id
}
