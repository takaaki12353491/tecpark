resource "github_repository_environment" "main" {
  repository  = var.github_repository
  environment = var.env
}

resource "github_actions_environment_variable" "aws_region" {
  repository    = github_repository_environment.main.repository
  environment   = github_repository_environment.main.environment
  variable_name = "AWS_REGION"
  value         = data.aws_region.current.name
}

resource "github_actions_environment_secret" "aws_github_actions_iam_role_arn" {
  repository      = github_repository_environment.main.repository
  environment     = github_repository_environment.main.environment
  secret_name     = "AWS_GITHUB_ACTIONS_IAM_ROLE_ARN"
  plaintext_value = aws_iam_role.github_actions.arn
}
