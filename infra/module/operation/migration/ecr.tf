resource "aws_ecr_repository" "migration" {
  name = "migration"

  tags = {
    Name = "migration"
  }
}
