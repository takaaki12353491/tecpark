variable "availability_zones" {
  type = list(string)
  default = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "security_group_bastion_id" {
  type = string
}
