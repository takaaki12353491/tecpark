resource "aws_ssm_parameter" "main_db_host" {
  name  = "MAIN_DB_HOST"
  type  = "String"
  value = aws_db_instance.main.address
}

resource "aws_ssm_parameter" "main_db_port" {
  name  = "MAIN_DB_PORT"
  type  = "String"
  value = aws_db_instance.main.port
}

resource "aws_ssm_parameter" "main_db_database" {
  name  = "MAIN_DB_DATABASE"
  type  = "String"
  value = aws_db_instance.main.db_name
}

resource "aws_ssm_parameter" "main_db_username" {
  name  = "MAIN_DB_USERNAME"
  type  = "String"
  value = aws_db_instance.main.username
}
