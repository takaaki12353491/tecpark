include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "./"
}

inputs = {
  stg_name_servers = split(",", get_env("STG_NAME_SERVERS"))
}
