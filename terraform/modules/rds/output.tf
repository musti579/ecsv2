output "db_secret_arn" {
  value = aws_db_instance.rds_postgres.master_user_secret[0].secret_arn
}