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
  subnet_ids = values(var.private_subnet_ids)

  tags = {
    Name = "private"
  }
}

resource "random_string" "rdb_password" {
  length  = 16
  special = true
}

resource "aws_db_instance" "main" {
  engine         = "mysql"
  engine_version = "8.0"

  identifier = "mysql"

  username = "admin_${var.env}"
  password = random_string.rdb_password.result

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.datastore.id]
  publicly_accessible    = false
  port                   = 3306

  db_name              = "${var.project}_${var.env}"
  parameter_group_name = aws_db_parameter_group.mysql.name
  option_group_name    = aws_db_option_group.mysql.name

  # バックアップを行ってからメンテナンスを行うように時間設定
  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  deletion_protection = true
  skip_final_snapshot = false
  apply_immediately   = true

  final_snapshot_identifier = "main-final-snapshot-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  tags = {
    Name = "main"
  }
}
