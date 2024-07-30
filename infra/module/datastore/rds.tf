resource "aws_db_parameter_group" "mysql_standalone_pg" {
  name   = "${var.project}-${var.env}-mysql-standalone-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}
