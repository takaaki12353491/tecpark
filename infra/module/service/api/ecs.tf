resource "aws_ecs_cluster" "api" {
  name = "api"

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
      environment = [
        {
          name  = "MYSQL_HOST",
          value = var.main_db_host
        },
        {
          name  = "MYSQL_PORT",
          value = var.main_db_port
        },
        {
          name  = "MYSQL_DATABASE",
          value = var.main_db_database
        },
        {
          name  = "MYSQL_USER",
          value = var.main_db_username
        },
      ]
      secrets = [
        {
          name      = "MYSQL_PASSWORD",
          valueFrom = var.main_db_password_secretsmanager_secret_arn
        }
      ]
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
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = values(var.private_subnet_ids)
    security_groups  = [aws_security_group.api.id]
    assign_public_ip = false
  }

  load_balancer {
    container_name   = "api"
    container_port   = 80
    target_group_arn = var.alb_target_group_api_arn
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  tags = {
    Name = "api"
  }
}
