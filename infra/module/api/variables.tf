variable "private_cidrs" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "alb_target_group_api_arn" {
  type = string
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}
