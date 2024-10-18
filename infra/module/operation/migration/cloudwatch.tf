resource "aws_cloudwatch_log_group" "migration" {
  name              = "/ecs/migration"
  retention_in_days = 7
}
