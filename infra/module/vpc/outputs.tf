output "azs" {
  value = local.azs
}

output "vpc_main_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnet_ids" {
  value = { for key, subnet in aws_subnet.private : key => subnet.id }
}

output "dummy_subnet_id" {
  value = aws_subnet.dummy.id
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
