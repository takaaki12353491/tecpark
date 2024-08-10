resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "bastion server role security group"
  vpc_id      = aws_vpc.main.id

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [local.all_cidr]
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

  tags = {
    Name = "bastion"
  }
}
