terraform {
  required_version = "~> 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
  }
}

provider "aws" {
  profile = "${local.project}-${var.terragrunt_env}"
  region  = local.region

  default_tags {
    tags = {
      Tool    = "${local.tool}"
      Project = "${local.project}"
      Env     = "${var.terragrunt_env}"
    }
  }
}

provider "aws" {
  alias   = "virginia"
  profile = "${local.project}-${var.terragrunt_env}"
  region  = "us-east-1"

  default_tags {
    tags = {
      Tool    = "${local.tool}"
      Project = "${local.project}"
      Env     = "${var.terragrunt_env}"
    }
  }
}

provider "github" {
  token = var.terragrunt_github_token
  owner = var.terragrunt_github_owner
}
