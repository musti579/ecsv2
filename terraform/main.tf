module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs

}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr

}

module "elasticache" {
source = "./modules/elasticache"

private_subnet_ids = module.vpc.private_subnet_ids
vpc_id             = module.vpc.vpc_id
vpc_cidr           = module.vpc.vpc_cidr

}

module "sqs" {
  source = "./modules/sqs"
}

module "endpoint" {
  source = "./modules/endpoint"

  vpc_id        = module.vpc.vpc_id
  private_rt    = module.vpc.private_rt  
  vpc_cidr      = module.vpc.vpc_cidr
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source        = "./modules/ecs"
  db_secret_arn = module.rds.db_secret_arn
  sqs_queue_arn = module.sqs.queue_arn
}