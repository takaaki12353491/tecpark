include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/ecs"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

dependency "web" {
  config_path = find_in_parent_folders("web")
}

inputs = {
  private_cidrs      = dependency.vpc.outputs.private_cidrs
  private_subnet_ids = dependency.vpc.outputs.private_subnet_ids

  alb_target_group_api_arn = dependency.web.outputs.alb_target_group_api_arn

  ecs_desired_count = 1
}
