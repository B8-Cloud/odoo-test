variable "ami_id" { type = string }
variable "instance_type" { type = string, default = "t3.medium" }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "key_name" { type = string }
variable "instance_name" { type = string, default = "odoo-server" }
variable "tags" { type = map(string), default = {} }
