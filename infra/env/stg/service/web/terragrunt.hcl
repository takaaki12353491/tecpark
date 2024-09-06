include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/service/web"
}

dependency "vpc" {
  config_path = "${find_in_parent_folders("common")}/vpc"
}

dependency "route53" {
  config_path = "${find_in_parent_folders("common")}/route53"
}

dependency "acm" {
  config_path = "${find_in_parent_folders("common")}/acm"
}

inputs = {
  main_vpc_id       = dependency.vpc.outputs.main_vpc_id
  public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
  dummy_subnet_id   = dependency.vpc.outputs.dummy_subnet_id

  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id

  main_acm_certificate_arn       = dependency.acm.outputs.main_acm_certificate_arn
  cloudfront_acm_certificate_arn = dependency.acm.outputs.cloudfront_acm_certificate_arn
}
