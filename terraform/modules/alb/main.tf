resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Application load balancer security group"
  vpc_id      = var.vpc_id

 # Allow all inbound traffic.
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_lb" "alb" {
  name               = "ecs2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "ecs2-alb"
  }
}


resource "aws_security_group" "ecs2-sg" {
  name        = "ecs2-sg"
  description = "Application load balancer security group for ecs task"
  vpc_id      = var.vpc_id

 # Allow all inbound traffic.
  ingress {
    description     = "api from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = var.alb_sg.id
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = var.alb_sg.id
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


