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