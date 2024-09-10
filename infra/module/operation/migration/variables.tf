variable "github_repository" {
  type = string
}

variable "env" {
  type = string
}

variable "image_tag" {
  type    = string
  default = "latest"
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
