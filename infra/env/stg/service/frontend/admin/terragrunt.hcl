include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/service/frontend/admin"
}

dependency "dns" {
  config_path = "${find_in_parent_folders("github.com/takaaki12353491/tecpark/backend/common")}/dns"
}

dependency "certificate" {
  config_path = "${find_in_parent_folders("github.com/takaaki12353491/tecpark/backend/common")}/certificate"
}

inputs = {
  main_route53_zone_id = dependency.dns.outputs.main_route53_zone_id

  cloudfront_acm_certificate_arn = dependency.certificate.outputs.cloudfront_acm_certificate_arn
}
