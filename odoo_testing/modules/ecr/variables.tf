variable "project_name" {
  description = "Project name for tagging and naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Extra tags to apply to resources"
  type        = map(string)
  default     = {}
}
