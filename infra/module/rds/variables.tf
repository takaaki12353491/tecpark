variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "api_security_group_id" {
  type = string
}

variable "bastion_security_group_id" {
  type = string
}
