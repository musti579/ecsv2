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


resource "aws_iam_role_policy_attachment" "execution_managed" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}