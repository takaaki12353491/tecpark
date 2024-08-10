resource "aws_security_group" "web" {
  name        = "web"
  description = "web front role security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [local.all_cidr]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [local.all_cidr]
  }

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [local.all_cidr]
  }

  tags = {
    Name = "web"
  }
}
