resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.eu-north-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [var.private_rt]


 security_group_ids = [
    aws_security_group.sg1.id,
  ]

  tags = {
    name = "s3 endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            =  var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

 
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

}

resource "aws_vpc_endpoint" "sqs_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.sqs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

  
}

resource "aws_vpc_endpoint" "cloudwatch_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

  
}

resource "aws_vpc_endpoint" "secret_manager_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.eu-north-1.secretsmanager"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.sg1.id,
  ]

}

