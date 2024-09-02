provider "aws" {
  region  = var.region
  profile = var.profile
}

module "ec2" {
  source         = "./modules/ec2/"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  region          = var.region
  instance_name   = var.instance_name
  private_key_path = var.private_key_path
}


module "s3" {
  source         = "./modules/s3/"
  bucket_name     = var.bucket_name
}

