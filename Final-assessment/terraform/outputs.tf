# outputs.tf
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "master_instance_id" {
  value = module.compute.master_instance_id
}

output "worker_instance_ids" {
  value = module.compute.worker_instance_ids
}

output "s3_bucket_name" {
  value = module.storage.bucket_name
}

output "role_name" {
  value = module.iam.role_name
}

output "instance_profile_name" {
  value = module.iam.instance_profile_name
}