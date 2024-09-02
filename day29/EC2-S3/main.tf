provider "aws" {
  region  = "us-east-1"
}

module "ec2" {
  source         = "./modules/ec2/"
  ami_id          = "ami-04a81a99f5ec58529"
  instance_type   = var.instance_type
  region          = var.region
  instance_name   = var.instance_name
}

module "s3" {
  source         = "./modules/s3/"
  bucket_name     = var.bucket
}
