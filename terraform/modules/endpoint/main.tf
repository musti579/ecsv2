resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.eu-north-1.s3_endpoint"
  private_dns_enabled = true

 security_group_ids = [
    aws_security_group.sg1.id,
  ]

  tags = {
    name = "s3 endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            =  var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.ecr_api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

 
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.ecr_dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

}

resource "aws_vpc_endpoint" "sqs_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-west-2.ec2"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

  
}

