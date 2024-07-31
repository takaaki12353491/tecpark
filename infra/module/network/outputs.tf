output "public_subnet_1a_id" {
  value = aws_subnet.public_1a.id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public_1c.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private_1a.id
}

output "private_subnet_1c_id" {
  value = aws_subnet.private_1c.id
}

output "security_group_datastore_id" {
  value = aws_security_group.datastore
}

output "security_group_bastion_id" {
  value = aws_security_group.bastion.id
}
