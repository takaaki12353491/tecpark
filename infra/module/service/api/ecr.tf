resource "aws_ecr_repository" "api" {
  name = "api"

  tags = {
    Name = "api"
  }
}