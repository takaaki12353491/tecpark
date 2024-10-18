data "aws_region" "current" {}

data "aws_vpc_endpoint_service" "logs" {
  service = "logs"
}
