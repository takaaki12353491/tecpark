output "azs" {
  value = local.azs
}

output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "private_cidrs" {
  value = local.private_cidrs
}

output "public_subnet_ids" {
  value = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnet_ids" {
  value = { for key, subnet in aws_subnet.private : key => subnet.id }
}
