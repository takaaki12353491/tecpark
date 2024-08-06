resource "aws_iam_role" "ecs_api" {
  name = "ecs-api"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
  ]

  tags = {
    Name = "ecs-api"
  }
}

resource "aws_ecs_cluster" "api" {
  name = "api"

  tags = {
    Name = "api"
  }
}

resource "aws_cloudwatch_log_group" "api" {
  name              = "/ecs/api"
  retention_in_days = 30

  tags = {
    Name = "api"
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_api.arn

  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${aws_ecr_repository.api.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api.name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "api"
  }
}

resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.api.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = values(var.private_subnet_ids)
    security_groups  = [var.security_group_api_id]
    assign_public_ip = false
  }

  load_balancer {
    container_name   = "api"
    container_port   = 80
    target_group_arn = var.alb_target_group_api_arn
  }

  tags = {
    Name = "api"
  }
}
