output "instance_ids" {
  value = aws_instance.web[*].id
}

output "eip_addresses" {
  value = aws_eip.web[*].public_ip
}
