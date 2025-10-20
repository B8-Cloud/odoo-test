variable "vpc_id" {}
variable "sg_name" {}
variable "allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
