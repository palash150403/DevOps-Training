# variables.tf

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "Palash-bucket"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
