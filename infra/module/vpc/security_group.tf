resource "aws_security_group" "vpc_endpoint" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = values(local.private_cidrs)
  }

  tags = {
    Name = "vpc-endpoint"
  }
}
