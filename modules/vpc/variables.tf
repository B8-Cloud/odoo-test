variable "project_name" {
  description = "odoo-test"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability zones to use "
  type        = list(string)
  default     = []
}

variable "create_nat_per_az" {
  description = "If true create a NAT gateway per AZ. If false create a single NAT in the first AZ."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Extra tags to attach"
  type        = map(string)
  default     = {}
}
