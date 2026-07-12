resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.eu-north-1.s3_endpoint"

  tags = {
    name = "s3 endpoint"
  }
}