provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  instance_count    = var.instance_count
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.app_sg_id
}

module "rds" {
  source            = "./modules/rds"
  instance_class    = var.rds_instance_class
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  security_group_id = module.security_groups.db_sg_id
  subnet_group_name = "db-subnet-group"
}

module "s3" {
  source        = "./modules/s3"
  bucket_prefix = var.bucket_prefix
}

module "iam_role" {
  source = "./modules/iam_roles"
}