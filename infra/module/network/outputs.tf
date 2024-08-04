output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "security_group_web_id" {
  value = aws_security_group.web.id
}

output "security_group_api_id" {
  value = aws_security_group.api.id
}

output "security_group_datastore_id" {
  value = aws_security_group.datastore.id
}

output "security_group_bastion_id" {
  value = aws_security_group.bastion.id
}
