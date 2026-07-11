terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Project = "ecs2"
    }
 }
} 

terraform {
  backend "s3" {
    bucket       = "mustafa-devopsv2-tfstate"
    key          = "global/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }
}
