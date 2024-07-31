locals {
  common_tags = {
    Tool    = var.tool
    Project = var.project
    Env     = var.env
  }
}
