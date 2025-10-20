#############################
# SECURITY GROUP
#############################
resource "aws_security_group" "this" {
  count       = var.create_sg ? 1 : 0
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge({ Name = var.sg_name }, var.tags)
}

#############################
# IAM ROLE
#############################
data "aws_iam_policy_document" "assume_role" {
  count = var.create_iam_role ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = var.assume_services
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.create_iam_role ? 1 : 0
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  description        = var.role_description
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "attach" {
  count      = var.create_iam_role ? length(var.attach_policies) : 0
  role       = aws_iam_role.this[0].name
  policy_arn = var.attach_policies[count.index]
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_iam_role ? 1 : 0
  name  = "${var.role_name}-profile"
  role  = aws_iam_role.this[0].name
}
