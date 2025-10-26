resource "aws_iam_role" "odoo_role" {
name = "${var.project_name}-role"

assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Action = "sts:AssumeRole"
Principal = {
Service = "[ec2.amazonaws.com](http://ec2.amazonaws.com/)"
}
Effect = "Allow"
Sid    = ""
}
]
})

tags = {
Project = var.project_name
}
}

resource "aws_iam_policy_attachment" "ec2_attach" {
name       = "${var.project_name}-policy-attach"
roles      = [aws_iam_role.odoo_role.name]
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}