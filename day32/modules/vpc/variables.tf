variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default = 2
}

# variable "cidr_block" {
#   description = "The CIDR block for the VPC"
#   type        = string
# }

# variable "public_subnet_cidrs" {
#   description = "List of CIDR blocks for the public subnets"
#   type        = list(string)
# }

# variable "private_subnet_cidrs" {
#   description = "List of CIDR blocks for the private subnets"
#   type        = list(string)
# }

# variable "availability_zones" {
#   description = "List of availability zones"
#   type        = list(string)
# }

# variable "public_subnet_count" {
#   description = "Number of public subnets"
#   type        = number
# }

# variable "private_subnet_count" {
#   description = "Number of private subnets"
#   type        = number
# }
