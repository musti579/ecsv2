resource "aws_lb" "alb" {
  name               = "ecsv2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "ecs2-alb"
  }
}