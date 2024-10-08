# VPC
resource "aws_vpc" "palash_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "palash_vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.palash_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "palash_public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.palash_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "palash_public_subnet_b"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.palash_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "palash_private_subnet_a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.palash_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "palash_private_subnet_b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "palash_igw" {
  vpc_id = aws_vpc.palash_vpc.id
  tags = {
    Name = "palash_igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.palash_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.palash_igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id # NAT Gateway should be in a public subnet

  tags = {
    Name = "nat-gateway"
  }
}

# Route Table for Private Subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.palash_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_rt"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private_subnet_a_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_b_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}