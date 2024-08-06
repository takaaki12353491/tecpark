resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_web_id]
  subnets            = values(var.public_subnet_ids)

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "api" {
  vpc_id      = var.vpc_main_id
  name        = "api"
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"

  tags = {
    Name = "api"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }

  tags = {
    Name = "http"
  }
}
