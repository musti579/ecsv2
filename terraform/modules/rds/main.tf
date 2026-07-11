

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "main"
  subnet_ids = aws_subnet.private_subnets[*].id
  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_instance" "db" {
  allocated_storage    = var.db_allocated_storage
  db_name              = var.db_name
  engine               = "postgres"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  manage_master_user_password = true
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  skip_final_snapshot  = true
}