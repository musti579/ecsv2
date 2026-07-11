module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = module.vpc.vpc_cidr
  public_subnet_cidrs  = module.vpc.public_subnet_cidrs
  private_subnet_cidrs = module.vpc.private_subnet_cidrs
  azs                  = module.vpc.azs 
  
}

module "rds" {
  source   = "./modules/rds"
  vpc_cidr = module.vpc.vpc_cidr

}