variable "tool" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_datastore_id" {
  type = string
}
