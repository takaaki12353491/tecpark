output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "alb_target_group_api_arn" {
  value = aws_lb_target_group.api.arn
}
