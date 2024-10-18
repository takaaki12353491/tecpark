include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/service/web"
}

dependency "network" {
  config_path = "${find_in_parent_folders("common")}/network"
}

dependency "dns" {
  config_path = "${find_in_parent_folders("common")}/dns"
}

dependency "certificate" {
  config_path = "${find_in_parent_folders("common")}/certificate"
}

inputs = {
  main_vpc_id       = dependency.network.outputs.main_vpc_id
  public_subnet_ids = dependency.network.outputs.public_subnet_ids
  dummy_subnet_id   = dependency.network.outputs.dummy_subnet_id

  main_route53_zone_id = dependency.dns.outputs.main_route53_zone_id

  main_acm_certificate_arn       = dependency.certificate.outputs.main_acm_certificate_arn
  cloudfront_acm_certificate_arn = dependency.certificate.outputs.cloudfront_acm_certificate_arn
}
