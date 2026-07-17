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
  api_image_url = module.ecr.api_repository_url
  redis_url     = module.elasticache.redis_endpoint
  sqs_queue_url = module.sqs.queue_url
  worker_image_url = module.ecr.worker_repository_url
  dashboard_image_url = module.ecr.dashboard_repository_url
}

module "alb" {
  source = "./modules/alb"

  public_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  alb_sg = var.alb_sg.id
}