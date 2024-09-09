variable "project" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "env" {
  type = string
}

variable "main_vpc_id" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_cidrs" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "dummy_subnet_id" {
  type = string
}
