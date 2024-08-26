variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the EC2 instances"
  type        = string
}

