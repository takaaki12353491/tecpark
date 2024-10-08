locals {
  local_vars = read_terragrunt_config(find_in_parent_folders("locals.tf"))
  
  tool   = local.local_vars.locals.tool
  region = local.local_vars.locals.region

  project = get_env("TF_VAR_terragrunt_project")
  env     = get_env("TF_VAR_terragrunt_env")

  locals_content    = file("locals.tf")
  variables_content = file("variables.tf")
  provider_content  = file("provider.tf")
  generated_content = join("\n", [
    local.locals_content, 
    local.variables_content, 
    local.provider_content
  ])
}

remote_state {
  backend = "s3"

  config = {
    bucket  = "${local.project}-${local.env}-tfstate"
    key     = "${basename(get_terragrunt_dir())}.tfstate"
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
  contents  = local.generated_content
}

inputs = {
  project = local.project
  env     = local.env
}
