provider "aws" {
  region = "us-west-1"
}

variable "ami_id" {
  default = "ami-0ff591da048329e00"
}

variable "db_password" {
  type      = string
  sensitive = true
}