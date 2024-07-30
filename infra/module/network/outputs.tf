output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public_subnet_1c.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}

output "private_subnet_1c_id" {
  value = aws_subnet.private_subnet_1c.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}
