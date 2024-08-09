variable "public_subnet_ids" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "security_group_api_id" {
  type = string
}

variable "ecr_api_repository_url" {
  type = string
}

variable "alb_target_group_api_arn" {
  type = string
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}
