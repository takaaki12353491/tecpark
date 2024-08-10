locals {
  all_cidr    = "0.0.0.0/0"
  alb_subnets = length(var.public_subnet_ids) == 1 ? concat(values(var.public_subnet_ids), [var.dummy_subnet_id]) : values(var.public_subnet_ids)
}
