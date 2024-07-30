resource "aws_db_parameter_group" "mysql_standalone_pg" {
  name   = "${var.project}-${var.env}-mysql-standalone-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_option_group" "mysql_standalone_og" {
  name                 = "${var.project}-${var.env}-mysql-standalone-og"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

resource "aws_db_subnet_group" "mysql_standalone_sg" {
  name = "${var.project}-${var.env}-mysql-standalone-sg"
  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1c_id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-standalone-sg"
    }
  )
}

resource "random_string" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql-standalone" {
  engine         = "mysql"
  engine_version = "8.0"

  identifier = "${var.project}-${var.env}-mysql-standalone"

  username = "${var.project}_${var.env}_admin"
  password = random_string.db_password.result

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.mysql_standalone_sg.name
  vpc_security_group_ids = [var.db_sg_id]
  publicly_accessible    = false
  port                   = 3306

  db_name              = "${var.project}_${var.env}"
  parameter_group_name = aws_db_parameter_group.mysql_standalone_pg.name
  option_group_name    = aws_db_option_group.mysql_standalone_og.name

  # バックアップを行ってからメンテナンスを行うように時間設定
  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  deletion_protection = true
  skip_final_snapshot = false
  apply_immediately   = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-mysql-standalone"
    }
  )
}
