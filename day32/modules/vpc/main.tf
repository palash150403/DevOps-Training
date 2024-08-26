resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "palash-vpc-new"
  }
}

resource "aws_subnet" "public" {
  count = var.public_subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "palash-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = var.private_subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "palash-private-subnet-${count.index}"
  }
}

# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# output "public_subnet_ids" j{
#   value = aws_subnet.public[*].id
# }

# output "private_subnet_ids" {
#   value = aws_subnet.private[*].id
# }
