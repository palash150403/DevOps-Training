provider "aws" {
  region = var.region
}

# Security Group
resource "aws_security_group" "Palash_sg" {
  name        = "Palash-app-sg"
  description = "Allow SSH and other necessary ports"
  vpc_id      = var.vpc_id  # Use the existing VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Palash-app-sg"
  }
}

# Subnet
resource "aws_subnet" "Palash_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.5.0/24"
  availability_zone =  "us-west-2a"  # Specify an availability zone within your region
  map_public_ip_on_launch = true
  tags = {
    Name = "Palash-subnet1"
  }
}



# EC2 Instance
resource "aws_instance" "Palash_app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.Palash_sg.id]
  subnet_id     = aws_subnet.Palash_subnet.id
  tags = {
    Name = "Palash-app-instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "Palash_app_bucket" {
  bucket = var.bucket_name
  # acl    = "private"

  tags = {
    Name = "Palash-app-bucket"
  }
}

# DynamoDB Table for state locking
resource "aws_dynamodb_table" "Palash_terraform_lock" {
  name           = var.dynamodb_table_name
  read_capacity   = 1
  write_capacity  = 1
  hash_key        = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Palash-terraform-lock-table"
  }
}
