variable "main_vpc_id" {
  type = string
}

variable "azs" {
  type = list(string)
  default = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
}

variable "private_cidrs" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}
