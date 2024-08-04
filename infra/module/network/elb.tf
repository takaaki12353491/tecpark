resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = aws_subnet.public[*].id

  tags = merge(
    local.common_tags,
    {
      Name = "alb"
    }
  )
}

resource "aws_lb_target_group" "api" {
  vpc_id   = aws_vpc.main.id
  name     = "api"
  protocol = "HTTP"
  port     = 80

  tags = merge(
    local.common_tags,
    {
      Name = "api"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }

  tags = merge(
    local.common_tags,
    {
      Name = "http"
    }
  )
}
