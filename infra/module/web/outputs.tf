output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "alb_target_group_api_arn" {
  value = aws_lb_target_group.api.arn
}

output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_route53_record_fqdn" {
  value = aws_route53_record.alb.fqdn
}
