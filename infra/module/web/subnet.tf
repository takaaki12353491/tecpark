# シングルAZでもALBを作成できるようにするためのサブネット
resource "aws_subnet" "dummy" {
  vpc_id                  = var.main_vpc_id
  availability_zone       = "${data.aws_region.current.name}c"
  cidr_block              = local.dummy_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "dummy"
    Type = "public"
  }
}
