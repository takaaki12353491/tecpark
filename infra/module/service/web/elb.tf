resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = local.alb_subnets
}

resource "aws_lb_target_group" "api" {
  vpc_id      = var.main_vpc_id
  name        = "api"
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"

  health_check {
    path = "/health"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTPS"
  port              = 443
  certificate_arn   = var.main_acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}
