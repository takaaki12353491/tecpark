include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/web"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")
}

dependency "route53" {
  config_path = find_in_parent_folders("route53")
}

inputs = {
  main_vpc_id       = dependency.vpc.outputs.main_vpc_id
  public_subnet_ids = dependency.vpc.outputs.public_subnet_ids

  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id
}
