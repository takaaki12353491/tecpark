locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  
  project = local.common_vars.locals.project
  tool    = local.common_vars.locals.tool
  region  = local.common_vars.locals.region

  env = local.env_vars.locals.env
}

remote_state {
  backend = "s3"

  config = {
    bucket  = "${local.project}-${local.env}-tfstate"
    key     = "${basename(get_terragrunt_dir())}.tfstate"
    region  = "${local.region}"
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
  required_version = ">= 1.9.3"

  required_providers {
    aws = {
      version = "~> 5.60.0"
    }
  }
}

provider "aws" {
  profile = "${local.project}-${local.env}"
  region  = "${local.region}"

  default_tags {
    tags = {
      Tool    = "${local.tool}"
      Project = "${local.project}"
      Env     = "${local.env}"
    }
  }
}
EOF

}
