variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "odoo-test-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "sg_name" {
  description = "Security group name"
  default     = "odoo-test-sg"
}

variable "sg_description" {
  description = "Security group description"
  default     = "Allow SSH and Odoo"
}

variable "iam_role_name" {
  description = "IAM Role name for EC2"
  default     = "odoo-ec2-role"
}

variable "ec2_instance_name" {
  description = "EC2 instance name"
  default     = "odoo-test"
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  default     = "odoo-test-repo"
}

variable "project_name" {
  description = "Project name for tagging"
  default     = "odoo-test"
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "odoo-key"
}
