module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  private_rt = var.private_rt
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

module "endpoint" {
  source = "./modules/endpoint"

  vpc_id = module.vpc.vpc_id
  private_rt = module.vpc.private_rt
  
  
}