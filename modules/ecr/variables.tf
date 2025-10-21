variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "ECR image tag mutability"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for ECR repository"
}
