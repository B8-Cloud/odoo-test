# Toggles
variable "create_sg" { type = bool, default = true }
variable "create_iam_role" { type = bool, default = true }

# Security Group variables
variable "sg_name" { type = string }
variable "sg_description" { type = string, default = "Managed by Terraform" }
variable "vpc_id" { type = string }
variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# IAM Role variables
variable "role_name" { type = string }
variable "role_description" { type = string, default = "IAM Role managed by Terraform" }
variable "assume_services" { type = list(string), default = ["ec2.amazonaws.com"] }
variable "attach_policies" { type = list(string), default = [] }

# Tags
variable "tags" { type = map(string), default = {} }
