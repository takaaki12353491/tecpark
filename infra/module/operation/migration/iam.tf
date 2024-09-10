resource "aws_iam_role" "ecs_migration" {
  name = "ecs-migration"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
  ]

  tags = {
    Name = "ecs-migration"
  }
}
