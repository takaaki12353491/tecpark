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

variable "private_subnet_1a_id" {
  type = string
}

variable "private_subnet_1c_id" {
  type = string
}

variable "db_sg_id" {
  type = string
}
