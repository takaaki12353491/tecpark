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

variable "atlas_cloud_token" {
  type      = string
  sensitive = true
}
