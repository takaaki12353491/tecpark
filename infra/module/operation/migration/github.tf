resource "github_actions_environment_variable" "aws_migration_ecr_url" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MIGRATION_ECR_URL"
  value         = aws_ecr_repository.migration.repository_url
}

resource "github_actions_environment_variable" "aws_migration_ecs_cluster_name" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MIGRATION_ECS_CLUSTER_NAME"
  value         = aws_ecs_cluster.migration.name
}

resource "github_actions_environment_variable" "aws_migration_ecs_task_family" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_MIGRATION_ECS_TASK_FAMILY"
  value         = aws_ecs_task_definition.migration.family
}

resource "github_actions_secret" "atlas_cloud_token" {
  repository      = var.github_repository
  secret_name     = "ATLAS_CLOUD_TOKEN"
  plaintext_value = var.atlas_cloud_token
}
