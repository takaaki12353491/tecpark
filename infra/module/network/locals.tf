locals {
  common_tags = {
    Tool    = var.tool
    Project = var.project
    Env     = var.env
  }

  availability_zones = [
    "${data.aws_region.current.name}a",
    "${data.aws_region.current.name}c"
  ]
  all_cidr = "0.0.0.0/0"
  vpc_cidr = "10.0.0.0/16"
  public_cidrs = {
    for az in local.availability_zones : az => "10.0.${index(local.availability_zones, az) + 1}.0/24"
  }
  private_cidrs = {
    for az in local.availability_zones : az => "10.0.${index(local.availability_zones, az) + 3}.0/24"
  }
}
