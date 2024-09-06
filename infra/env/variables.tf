# moduleのvariableと被らないようにする
variable "terragrunt_env" {
  type = string
}

variable "terragrunt_github_token" {
  type      = string
  sensitive = true
}

variable "terragrunt_github_owner" {
  type = string
}
