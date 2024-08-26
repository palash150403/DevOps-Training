variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}

variable "subnet_group_name" {
  description = "The subnet group name for the RDS instance"
  type        = string
}
