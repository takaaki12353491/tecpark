locals {
  local_vars = read_terragrunt_config(find_in_parent_folders("locals.tf"))
  
  project           = local.local_vars.locals.project
  tool              = local.local_vars.locals.tool
  custom_domain     = local.local_vars.locals.custom_domain
  region            = local.local_vars.locals.region
  github_username   = local.local_vars.locals.github_username
  github_repository = local.local_vars.locals.github_repository

  env = get_env("TF_VAR_terragrunt_env")

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
  project           = local.project
  tool              = local.tool
  custom_domain     = local.custom_domain
  region            = local.region
  github_username   = local.github_username
  github_repository = local.github_repository
  env               = local.env
}
