# 全環境の定義 (`env/terragrunt.hcl`) をインクルードする
include "root" {
  path = find_in_parent_folders()
}

# 環境の定義 (`env.hcl`) を local.env.locals として参照できるようにする
locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project = local.common_vars.locals.project
  env = local.env_vars.locals.env
}

# モジュールを参照する
terraform {
  source = "${find_in_parent_folders("module")}/network"
}

# モジュールの入力値を指定する
inputs = {
  project = local.project
  env = local.env
}
