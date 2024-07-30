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

resource "aws_db_option_group" "mysql_standalone_og" {
  name                 = "${var.project}-${var.env}-mysql-standalone-og"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

resource "aws_db_subnet_group" "mysql_standalone_sg" {
  name = "${var.project}-${var.env}-mysql-standalone-sg"
  subnet_ids = [
    var.private_subnet_1a_id,
    var.private_subnet_1c_id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-standalone-sg"
    }
  )
}
