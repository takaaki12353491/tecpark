resource "aws_ssm_parameter" "rds_main_host" {
  name  = "RDS_MAIN_HOST"
  type  = "String"
  value = aws_db_instance.main.address

  tags = {
    Name = "rds-main-host"
  }
}

resource "aws_ssm_parameter" "rds_main_port" {
  name  = "RDS_MAIN_PORT"
  type  = "String"
  value = aws_db_instance.main.port

  tags = {
    Name = "rds-main-port"
  }
}

resource "aws_ssm_parameter" "rds_main_database" {
  name  = "RDS_MAIN_DATABASE"
  type  = "String"
  value = aws_db_instance.main.db_name

  tags = {
    Name = "rds-main-database"
  }
}

resource "aws_ssm_parameter" "rds_main_username" {
  name  = "RDS_MAIN_USERNAME"
  type  = "String"
  value = aws_db_instance.main.username

  tags = {
    Name = "rds-main-username"
  }
}
