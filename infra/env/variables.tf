# moduleのvariableと被らないようにするためにプレフィックスにterragruntを付ける
variable "terragrunt_project" {
  type = string
}

variable "terragrunt_github_token" {
  type      = string
  sensitive = true
}

variable "terragrunt_github_owner" {
  type = string
}

variable "terragrunt_env" {
  type = string
}
