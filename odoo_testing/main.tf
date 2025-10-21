module "vpc" {
  source               = "./modules/vpc"
  project_name         = "odoo-test"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  create_nat_per_az    = true
}

module "sg" {
  source         = "./modules/sg"
  sg_name        = var.sg_name
  sg_description = var.sg_description
  vpc_id         = module.vpc.vpc_id
}

module "iam" {
  source    = "./modules/iam"
  role_name = var.iam_role_name
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

module "ec2" {
  source               = "./modules/instance"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_id    = module.sg.sg_id
  key_name             = var.key_name
  iam_instance_profile = module.iam.instance_profile_name
  project_name         = var.project_name
  environment          = var.environment
}

