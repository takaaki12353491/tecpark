resource "aws_db_parameter_group" "mysql" {
  name   = "main"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  tags = {
    Name = "mysql"
  }
}

resource "aws_db_option_group" "mysql" {
  name                 = "mysql"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  tags = {
    Name = "mysql"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private"
  subnet_ids = local.rds_subnets

  tags = {
    Name = "private"
  }
}

resource "random_string" "main_db_password" {
  length = 16
  # エスケープ処理しなくてもいいように特殊文字は使わない
  special = false
}

resource "aws_db_instance" "main" {
  identifier = "main"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = length(var.azs) >= 2
  availability_zone      = var.azs[0]
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  port                   = 3306

  username             = "admin_${var.env}"
  password             = random_string.main_db_password.result
  db_name              = "${var.project}_${var.env}"
  parameter_group_name = aws_db_parameter_group.mysql.name
  option_group_name    = aws_db_option_group.mysql.name

  # バックアップを行ってからメンテナンスを行うように時間設定
  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = true

  deletion_protection = true
  skip_final_snapshot = false
  apply_immediately   = true

  final_snapshot_identifier = "main-final-snapshot-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  tags = {
    Name = "main"
  }
}
