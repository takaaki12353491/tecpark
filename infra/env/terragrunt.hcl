locals {
  project = "tecpark"
  env     = get_env("TF_VAR_env")
  tool    = "Terraform"

  # AWS
  region = "ap-northeast-1"

  # GitHub
  github_token = get_env("TF_VAR_github_token")
  github_owner = get_env("TF_VAR_github_owner")

  paths = regexall("[\\w]+", "${path_relative_to_include()}")
}

remote_state {
  backend = "s3"

  config = {
    bucket  = "${local.project}-${local.env}-tfstate"
    // 下記のように環境ディレクトリをkeyから削除したいが正規表現の後読みがサポートされていないので仕方なくreplaceを使う
    // regex("(?<=${local.env}).*", path_relative_to_include())
    key     = "${replace("foobar${path_relative_to_include()}", "foobar${local.env}/", "")}.tfstate"
    region  = "${local.region}"
    profile = "${local.project}-${local.env}"
    encrypt = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  // tfファイルから読み込むこともできるが、terragruntで取得した値が渡せないなど不便なのでヒアドキュメントで定義する
  contents  = <<EOF
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
  profile = "${local.project}-${local.env}"
  region  = "${local.region}"

  default_tags {
    tags = {
      Project = "${local.project}"
      Env     = "${local.env}"
      Tool    = "${local.tool}"
      Type    = "${local.paths[1]}"
    }
  }
}

provider "aws" {
  alias   = "virginia"
  profile = "${local.project}-${local.env}"
  region  = "us-east-1"

  default_tags {
    tags = {
      Tool    = "${local.tool}"
      Project = "${local.project}"
      Env     = "${local.env}"
    }
  }
}

provider "github" {
  token = ${local.github_token}
  owner = ${local.github_owner}
}
EOF
}

inputs = {
  project = local.project
  env     = local.env
}
