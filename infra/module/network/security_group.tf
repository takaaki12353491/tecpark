resource "aws_security_group" "vpc_endpoint" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "vpc_endpoint_from_app" {
  security_group_id        = aws_security_group.vpc_endpoint.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "web front role security group"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "web"
    }
  )
}

resource "aws_security_group_rule" "web_from_internet_http" {
  security_group_id = aws_security_group.web.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_from_internet_https" {
  security_group_id = aws_security_group.web.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_to_app" {
  security_group_id        = aws_security_group.web.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group" "app" {
  name        = "app"
  description = "application server role security group"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "app"
    }
  )
}

resource "aws_security_group_rule" "app_from_web" {
  security_group_id        = aws_security_group.app.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "app_to_internet_https" {
  security_group_id = aws_security_group.app.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "app_to_vpc_endpoint" {
  security_group_id        = aws_security_group.app.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.vpc_endpoint.id
}

resource "aws_security_group_rule" "app_to_datastore" {
  security_group_id        = aws_security_group.app.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.datastore.id
}

resource "aws_security_group" "datastore" {
  name        = "datastore"
  description = "database role security group"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "datastore"
    }
  )
}

resource "aws_security_group_rule" "datastore_from_app" {
  security_group_id        = aws_security_group.datastore.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "datastore_from_bastion" {
  security_group_id        = aws_security_group.datastore.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "bastion server role security group"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "bastion"
    }
  )
}

resource "aws_security_group_rule" "bastion_to_internet_http" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_to_internet_https" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_to_datastore" {
  security_group_id        = aws_security_group.bastion.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.datastore.id
}
