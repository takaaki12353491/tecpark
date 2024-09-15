include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/common/acm"
}

dependency "route53" {
  config_path = find_in_parent_folders("route53")
}

inputs = {
  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id
}
