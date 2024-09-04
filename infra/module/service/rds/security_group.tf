resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds role security group"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = values(var.private_cidrs)
  }

  tags = {
    Name = "rds"
  }
}
