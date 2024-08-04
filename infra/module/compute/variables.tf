variable "tool" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_api_id" {
  type = string
}

variable "security_group_bastion_id" {
  type = string
}

variable "ecr_repository_app_url" {
  type = string
}
