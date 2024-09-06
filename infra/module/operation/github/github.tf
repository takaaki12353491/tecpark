resource "github_repository_environment" "main" {
  repository  = var.github_repository
  environment = var.env
}

resource "github_actions_environment_variable" "aws_region" {
  repository    = github_repository_environment.main.repository
  environment   = github_repository_environment.main.environment
  variable_name = "AWS_REGION"
  value         = var.region
}
