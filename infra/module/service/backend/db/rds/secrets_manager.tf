resource "aws_secretsmanager_secret" "main_db_password" {
  name = "MAIN_DB_PASSWORD"
}

resource "aws_secretsmanager_secret_version" "main_db_password" {
  secret_id     = aws_secretsmanager_secret.main_db_password.id
  secret_string = aws_db_instance.main.password
}
