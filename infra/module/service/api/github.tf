resource "github_actions_environment_variable" "aws_api_ecr_url" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_API_ECR_URL"
  value         = aws_ecr_repository.api.repository_url
}

resource "github_actions_environment_variable" "aws_api_ecr_repository_name" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_API_ECR_REPOSITORY_NAME"
  value         = aws_ecr_repository.api.name
}

resource "github_actions_environment_variable" "aws_api_ecs_cluster_name" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_API_ECS_CLUSTER_NAME"
  value         = aws_ecs_cluster.api.name
}

resource "github_actions_environment_variable" "aws_api_ecs_task_family" {
  repository    = var.github_repository
  environment   = var.env
  variable_name = "AWS_API_ECS_TASK_FAMILY"
  value         = aws_ecs_task_definition.api.family
}
