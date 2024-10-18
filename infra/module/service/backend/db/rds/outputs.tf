output "main_db_host" {
  value = aws_db_instance.main.address
}

output "main_db_port" {
  value = aws_db_instance.main.port
}

output "main_db_database" {
  value = aws_db_instance.main.db_name
}

output "main_db_username" {
  value = aws_db_instance.main.username
}

output "main_db_password_secretsmanager_secret_arn" {
  value = aws_secretsmanager_secret.main_db_password.arn
}
