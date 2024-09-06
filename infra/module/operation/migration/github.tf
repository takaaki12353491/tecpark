resource "github_actions_environment_variable" "aws_migration_ecr_url" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MIGRATION_ECR_URL"
  value         = aws_ecr_repository.migration.repository_url
}
