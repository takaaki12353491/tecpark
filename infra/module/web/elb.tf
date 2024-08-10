resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = concat(values(var.public_subnet_ids), [aws_subnet.dummy.id])

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "api" {
  vpc_id      = var.main_vpc_id
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
