locals {
  rds_subnets = length(var.private_subnet_ids) == 1 ? concat(values(var.private_subnet_ids), [var.dummy_subnet_id]) : values(var.private_subnet_ids)
}
