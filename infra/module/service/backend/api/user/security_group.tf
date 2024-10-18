resource "aws_security_group" "api" {
  name        = "api"
  description = "api server role security group"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [var.web_security_group_id]
  }

  egress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [local.all_cidr]
  }

  egress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = values(var.private_cidrs)
  }
}
