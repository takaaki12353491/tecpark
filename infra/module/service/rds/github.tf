resource "github_actions_environment_variable" "aws_main_rds_host" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MAIN_RDS_HOST"
  value         = aws_db_instance.main.address
}

resource "github_actions_environment_variable" "aws_main_rds_port" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MAIN_RDS_PORT"
  value         = aws_db_instance.main.port
}

resource "github_actions_environment_variable" "aws_main_rds_database" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MAIN_RDS_DATABASE"
  value         = aws_db_instance.main.db_name
}

resource "github_actions_environment_variable" "aws_main_rds_username" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MAIN_RDS_USERNAME"
  value         = aws_db_instance.main.username
}

resource "github_actions_environment_secret" "aws_main_rds_password" {
  repository      = var.github_repository
  environment     = var.env
  secret_name     = "AWS_MAIN_RDS_PASSWORD"
  plaintext_value = aws_db_instance.main.password
}
