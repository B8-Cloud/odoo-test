resource "aws_ecr_repository" "myecr" {
  name = "${var.project_name}-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(
    {
      Name        = "${var.project_name}-ecr"
      Environment = var.environment
      Project     = var.project_name
    },
    var.tags
  )
}
