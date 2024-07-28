locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  
  project = local.common_vars.locals.project
  region = local.common_vars.locals.region
  env = local.env_vars.locals.env
}

# 各環境ごとの *.tfstate の入れ方についての定義
remote_state {
  backend = "s3"

  config = {
    bucket = "${local.project}-tfstate"
    key    = "${local.project}/${path_relative_to_include()}.tfstate"
    region = "${local.region}"
    profile = "${local.project}-${local.env}"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_version = ">= 1.3.7"

  required_providers {
    aws = {
      # See https://github.com/terraform-providers/terraform-provider-aws
      version = "~> 4.50.0"
    }
  }
}

provider "aws" {
  profile = "${local.project}-${local.env}"
  region  = "${local.region}"

  default_tags {
    tags = {
      Project = "${local.project}"
    }
  }
}
EOF

}

