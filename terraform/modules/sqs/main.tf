resource "aws_sqs_queue" "dlq" {
  name                      = "ecsv2-click-events-dlq"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "ecs2-click-events"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 20
  redrive_policy = jsonencode({
  maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}