include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/common/certificate"
}

dependency "dns" {
  config_path = find_in_parent_folders("dns")
}

inputs = {
  main_route53_zone_id = dependency.dns.outputs.main_route53_zone_id
}
