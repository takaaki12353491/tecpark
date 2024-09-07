resource "aws_ecs_cluster" "migration" {
  name = "migration"

  tags = {
    Name = "migration"
  }
}

resource "aws_ecs_task_definition" "migration" {
  family                   = "migration"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_migration.arn

  container_definitions = jsonencode([
    {
      name      = "migration"
      image     = "${aws_ecr_repository.migration.repository_url}:${var.image_tag}"
      essential = true

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.migration.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs-migration"
        }
      }
    }
  ])

  tags = {
    Name = "migration"
  }
}
