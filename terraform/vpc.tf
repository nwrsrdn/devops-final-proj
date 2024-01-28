resource "aws_vpc" "eks_cluster_vpc" {
  cidr_block           = "10.69.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.Engineer}_eks_cluster_vpc"
  }
}

resource "aws_subnet" "eks_public_subnet" {
  vpc_id                  = aws_vpc.eks_cluster_vpc.id
  cidr_block              = var.public_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  count                   = 2

  tags = {
    Name = "${var.Engineer}_eks_public_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "eks_private_subnet" {
  vpc_id                  = aws_vpc.eks_cluster_vpc.id
  cidr_block              = var.private_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  count                   = 2

  tags = {
    Name = "${var.Engineer}_eks_private_subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "eks_cluster_igw" {
  vpc_id = aws_vpc.eks_cluster_vpc.id

  tags = {
    Name = "${var.Engineer}_eks_igw"
  }
}

resource "aws_eip" "eks_cluster_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.Engineer}_eks_eip"
  }
}

resource "aws_nat_gateway" "eks_cluster_nat" {
  allocation_id = aws_eip.eks_cluster_eip.id
  subnet_id     = aws_subnet.eks_public_subnet[1].id

  tags = {
    Name = "${var.Engineer}_eks_nat"
  }
}

resource "aws_route_table" "eks_cluster_public_rt" {
  vpc_id = aws_vpc.eks_cluster_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_cluster_igw.id
  }

  tags = {
    Name = "${var.Engineer}_eks_public_rt"
  }
}

resource "aws_route_table" "eks_cluster_private_rt" {
  vpc_id = aws_vpc.eks_cluster_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_cluster_nat.id
  }

  tags = {
    Name = "${var.Engineer}_eks_public_rt"
  }
}

resource "aws_route_table_association" "eks_cluster_private_rta" {
  route_table_id = aws_route_table.eks_cluster_private_rt.id
  subnet_id      = aws_subnet.eks_private_subnet[count.index].id
  count          = 2
}

resource "aws_route_table_association" "eks_cluster_public_rta" {
  route_table_id = aws_route_table.eks_cluster_public_rt.id
  subnet_id      = aws_subnet.eks_public_subnet[count.index].id
  count          = 2
}
