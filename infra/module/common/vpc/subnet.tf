resource "aws_subnet" "public" {
  for_each = local.public_cidrs

  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.key}"
    Type = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_cidrs

  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "private-${each.key}"
    Type = "private"
  }
}

# シングルAZでもマルチAZ用のリソースを作成できるようにするためのサブネット
resource "aws_subnet" "dummy" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${data.aws_region.current.name}c"
  cidr_block              = local.dummy_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "dummy"
    Type = "public"
  }
}
