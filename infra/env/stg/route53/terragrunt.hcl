include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/route53"
}

dependency "elb" {
  config_path = find_in_parent_folders("elb")
}

inputs = {
  domain = get_env("DOMAIN", "stg.tecpark.net")

  alb_dns_name = dependency.elb.outputs.alb_dns_name
  alb_zone_id  = dependency.elb.outputs.alb_zone_id
}
