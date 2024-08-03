variable "tool" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}
