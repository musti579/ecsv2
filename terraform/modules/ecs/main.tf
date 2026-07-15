resource "aws_ecs_cluster" "ecs2_cluster" {
  name = "ecs2-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_api_logs" {
  name              = "/ecs/ecs2-api"
  retention_in_days = 14

  tags = {
    Name = "ecs2-api-logs"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_worker_logs" {
  name              = "/ecs/ecs2-worker"
  retention_in_days = 14

  tags = {
    Name = "ecs2-worker-logs"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_dashboard_logs" {
  name              = "/ecs/ecs2-dashboard"
  retention_in_days = 14

  tags = {
    Name = "ecs2-dashboard-logs"
  }
}


resource "aws_iam_role" "execution" {
  name = "ecs2-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "ecs2-task-execution-role"
  }
}

resource "aws_iam_role_policy" "execution_secrets" {
  name = "ecs2-execution-secrets"
  role = aws_iam_role.execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["secretsmanager:GetSecretValue"]
      Resource = var.db_secret_arn
    }]
  })
}


resource "aws_iam_role_policy_attachment" "execution_managed" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "api_task" {
  name = "ecs2-api-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "ecs2-api-task-role"
  }
}


resource "aws_iam_role_policy" "api_sqs" {
  name = "ecs2-api-sqs"
  role = aws_iam_role.api_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sqs:SendMessage"
      Resource = var.sqs_queue_arn
    }]
  })
}


resource "aws_iam_role" "worker_task" {
  name = "ecs2-worker-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "ecs2-worker-task-role"
  }
}

resource "aws_iam_role_policy" "worker_sqs" {
  name = "ecs2-worker-sqs"
  role = aws_iam_role.worker_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action = [
    "sqs:ReceiveMessage",           
    "sqs:DeleteMessage",
    "sqs:GetQueueAttributes"
    ]
      Resource = var.sqs_queue_arn
    }]
  })
}


resource "aws_ecs_task_definition" "api" {
  family                   = "ecs2-api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.api_task.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${var.api_image_url}:v1"
      essential = true
      portMappings = [
        { containerPort = 8080, protocol = "tcp" }
      ]
      environment = [
        { name = "REDIS_URL",     value = var.redis_url },
        { name = "SQS_QUEUE_URL", value = var.sqs_queue_url },
        { name = "PORT",          value = "8080" }
      ]
      secrets = [
        { name = "DB_PASSWORD", valueFrom = var.db_secret_arn }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/ecs2-api"
          "awslogs-region"        = "eu-north-1"
          "awslogs-stream-prefix" = "api"
        }
      }
    }
  ])
}