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
    cidr_blocks = local.private_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "web"
    }
  )
}

resource "aws_security_group" "api" {
  name        = "api"
  description = "api server role security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.web.id]
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
    cidr_blocks = local.private_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "api"
    }
  )
}

resource "aws_security_group" "datastore" {
  name        = "datastore"
  description = "database role security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    security_groups = [
      aws_security_group.api.id,
      aws_security_group.bastion.id
    ]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "datastore"
    }
  )
}

resource "aws_security_group" "vpc_endpoint" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = local.private_cidrs
  }
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "bastion server role security group"
  vpc_id      = aws_vpc.main.id

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = local.public_cidrs
  }

  egress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = local.public_cidrs
  }

  egress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = local.private_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "bastion"
    }
  )
}
