output "repo_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.myecr.repository_url
}

output "repository_name" {
  description = "ECR repository name"
  value       = aws_ecr_repository.myecr.name
}
