provider "aws" {
  region = var.aws_region
  profile = "default"
}

module "vpc" {
  source = "./modules/vpc"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                 = var.azs
  create_nat_per_az   = var.create_nat_per_az
  tags                = var.tags
}

module "security_group" {
  source       = "./modules/security-group"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-0abcd1234efgh5678"
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.security_group.sg_id]
  key_name           = "my-key"
  name               = "devops-ec2"
  tags = {
    Environment = "dev"
  }
}

module "ecr" {
  source = "./modules/ecr"
  name   = "devops-repo"
  tags = {
    Environment = "dev"
  }
}