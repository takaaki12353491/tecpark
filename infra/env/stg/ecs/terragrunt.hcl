include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/ecs"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

dependency "elb" {
  config_path = find_in_parent_folders("elb")
}

inputs = {
  public_subnet_ids         = dependency.vpc.outputs.public_subnet_ids
  private_subnet_ids        = dependency.vpc.outputs.private_subnet_ids
  security_group_api_id     = dependency.vpc.outputs.security_group_api_id

  alb_target_group_api_arn = dependency.elb.outputs.alb_target_group_api_arn
}
