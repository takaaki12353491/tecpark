locals {
  azs = [
    for suffix in var.az_suffixes : "${data.aws_region.current.name}${suffix}"
  ]
  all_cidr = "0.0.0.0/0"
  vpc_cidr = "10.0.0.0/16"
  public_cidrs = {
    for az in local.azs : az => "10.0.${index(local.azs, az) + 1}.0/24"
  }
  private_cidrs = {
    for az in local.azs : az => "10.0.${index(local.azs, az) + 3}.0/24"
  }
}
