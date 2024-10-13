variable "env" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "main_vpc_id" {
  type = string
}

variable "private_cidrs" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "web_security_group_id" {
  type = string
}

variable "alb_target_group_api_arn" {
  type = string
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}

variable "main_db_host" {
  type = string
}

variable "main_db_port" {
  type = string
}

variable "main_db_database" {
  type = string
}

variable "main_db_username" {
  type = string
}

variable "main_db_password_secretsmanager_secret_arn" {
  type = string
}
