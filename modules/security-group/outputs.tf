output "sg_id" {
  value       = var.create_sg ? aws_security_group.this[0].id : null
  description = "Security Group ID"
}

output "role_name" {
  value       = var.create_iam_role ? aws_iam_role.this[0].name : null
  description = "IAM Role Name"
}

output "instance_profile_name" {
  value       = var.create_iam_role ? aws_iam_instance_profile.this[0].name : null
  description = "IAM Instance Profile Name"
}
