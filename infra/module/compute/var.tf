locals {
  common_tags = {
    Project = var.project
    Env     = var.env
  }
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "app_sg_id" {
  type = string
}
