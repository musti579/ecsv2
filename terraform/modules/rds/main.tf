
# using private subnets so the db is never directly reachable from the internet
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "rds-subnet-group"
  }
}

# created rds database port exposed by default
resource "aws_db_instance" "rds_postgres" {
  allocated_storage    = var.db_allocated_storage
  db_name              = var.db_name
  engine               = "postgres"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  manage_master_user_password = true
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]


}

resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp" 
    cidr_blocks = [var.vpc_cidr]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
}