include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/service/front_admin"
}

dependency "route53" {
  config_path = "${find_in_parent_folders("common")}/route53"
}

dependency "acm" {
  config_path = "${find_in_parent_folders("common")}/acm"
}

inputs = {
  main_route53_zone_id = dependency.route53.outputs.main_route53_zone_id

  cloudfront_acm_certificate_arn = dependency.acm.outputs.cloudfront_acm_certificate_arn
}
