resource "aws_secretsmanager_secret" "rds_main_password" {
  name = "RDS_MAIN_PASSWORD"

  tags = {
    Name = "rds-main-password"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "rds_main_password_version" {
  secret_id     = aws_secretsmanager_secret.rds_main_password.id
  secret_string = random_string.rdb_password.result

  lifecycle {
    prevent_destroy = true
  }
}
