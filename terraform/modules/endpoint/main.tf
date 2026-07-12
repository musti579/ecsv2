resource "aws_vpc_endpoint" "s3 endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.s3"

  tags = {
    name = "s3 endpoint"
  }
}