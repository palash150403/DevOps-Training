output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "app_sg_id" {
  value = module.security_groups.app_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "eip_addresses" {
  value = module.ec2.eip_addresses
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "iam_role_arn" {
  value = module.iam_role.iam_role_arn
}
