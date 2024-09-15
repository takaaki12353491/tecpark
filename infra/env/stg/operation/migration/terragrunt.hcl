include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/operation/migration"
}

dependency "rds" {
  config_path = "${find_in_parent_folders("service")}/rds"
}

inputs = {
  main_db_host                               = dependency.rds.outputs.main_db_host
  main_db_port                               = dependency.rds.outputs.main_db_port
  main_db_database                           = dependency.rds.outputs.main_db_database
  main_db_username                           = dependency.rds.outputs.main_db_username
  main_db_password_secretsmanager_secret_arn = dependency.rds.outputs.main_db_password_secretsmanager_secret_arn
}
