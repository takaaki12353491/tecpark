resource "aws_security_group" "web_sg" {
  name        = "${var.project}-${var.env}-web-sg"
  description = "web front role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-web-sg"
    }
  )
}

resource "aws_security_group_rule" "web_in_http" {
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_in_https" {
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_out_tcp3000" {
  security_group_id        = aws_security_group.web_sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3000
  to_port                  = 3000
  source_security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group" "app_sg" {
  name        = "${var.project}-${var.env}-app-sg"
  description = "application server role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-app-sg"
    }
  )
}

resource "aws_security_group_rule" "app_in_tcp3000" {
  security_group_id        = aws_security_group.app_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3000
  to_port                  = 3000
  source_security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "app_out_tcp3306" {
  security_group_id        = aws_security_group.app_sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "app_out_https" {
  security_group_id = aws_security_group.app_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "db_sg" {
  name        = "${var.project}-${var.env}-db-sg"
  description = "database role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-db-sg"
    }
  )
}

resource "aws_security_group_rule" "db_from_app" {
  security_group_id        = aws_security_group.db_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "db_from_bastion" {
  security_group_id        = aws_security_group.db_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group" "bastion" {
  name        = "${var.project}-${var.env}-bastion"
  description = "bastion server role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-bastion"
    }
  )
}

resource "aws_security_group_rule" "bastion_in_https" {
  security_group_id = aws_security_group.bastion.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_out_https" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_to_db" {
  security_group_id        = aws_security_group.bastion.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.db_sg.id
}