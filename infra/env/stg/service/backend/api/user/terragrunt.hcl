include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/service/backend/api/user"
}

dependency "network" {
<<<<<<< HEAD
  config_path = "${find_in_parent_folders("github.com/takaaki12353491/tecpark/backend/common")}/network"
=======
  config_path = "${find_in_parent_folders("common")}/network"
>>>>>>> 43b153f (Merge pull request #91 from takaaki12353491/fix/infra)
}

dependency "web" {
  config_path = "${find_in_parent_folders("web")}"
}

dependency "rds" {
  config_path = "${find_in_parent_folders("db")}/rds"
}

inputs = {
  main_vpc_id        = dependency.network.outputs.main_vpc_id
  private_cidrs      = dependency.network.outputs.private_cidrs
  private_subnet_ids = dependency.network.outputs.private_subnet_ids

  web_security_group_id    = dependency.web.outputs.web_security_group_id
  alb_target_group_api_arn = dependency.web.outputs.alb_target_group_api_arn

  ecs_desired_count = 1

  main_db_host                               = dependency.rds.outputs.main_db_host
  main_db_port                               = dependency.rds.outputs.main_db_port
  main_db_database                           = dependency.rds.outputs.main_db_database
  main_db_username                           = dependency.rds.outputs.main_db_username
  main_db_password_secretsmanager_secret_arn = dependency.rds.outputs.main_db_password_secretsmanager_secret_arn
}
