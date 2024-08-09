variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "domain" {
  type = string
}

variable "sso_roles" {
  type = list(string)
}
