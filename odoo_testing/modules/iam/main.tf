resource "aws_iam_role" "ec2_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = var.role_name
  }
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.role_name}-profile"
  role = aws_iam_role.ec2_role.name
}