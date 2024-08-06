variable "vpc_main_id" {
  type = string
}

variable "public_subnet_ids" {
  type = map(string)
}

variable "security_group_web_id" {
  type = string
}
