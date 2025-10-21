data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs        = length(var.azs) > 0 ? var.azs : slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
  zone_count = length(local.azs)
}

resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name        = "${var.project_name}-vpc"
      Environment = var.environment
      Project     = var.project_name
    },
    var.tags
  )
}

resource "aws_internet_gateway" "myvpc" {
  vpc_id = aws_vpc.myvpc.id

  tags = merge(
    {
      Name    = "${var.project_name}-igw"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  count                   = local.zone_count
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name    = "${var.project_name}-public-${count.index + 1}"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  count                   = local.zone_count
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name    = "${var.project_name}-private-${count.index + 1}"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myvpc.id
  }

  tags = merge(
    {
      Name    = "${var.project_name}-public-rt"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_route_table_association" "public_assoc" {
  count          = local.zone_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_eips" {
  count = var.create_nat_per_az ? local.zone_count : 1

  tags = merge(
    {
      Name    = "${var.project_name}-nat-eip-${count.index + 1}"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_nat_gateway" "nat" {
  count         = var.create_nat_per_az ? local.zone_count : 1
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.myvpc]

  tags = merge(
    {
      Name    = "${var.project_name}-nat-${count.index + 1}"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_route_table" "private" {
  count  = local.zone_count
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.create_nat_per_az ? aws_nat_gateway.nat[count.index].id : aws_nat_gateway.nat[0].id
  }

  tags = merge(
    {
      Name    = "${var.project_name}-private-rt-${count.index + 1}"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_route_table_association" "private_assoc" {
  count          = local.zone_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
