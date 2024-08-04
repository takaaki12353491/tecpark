resource "aws_subnet" "public" {
  count = length(local.availability_zones)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(local.availability_zones, count.index)
  cidr_block              = element(local.public_cidrs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public${count.index + 1}"
      Type = "public"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(local.availability_zones)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(local.availability_zones, count.index)
  cidr_block              = element(local.private_cidrs, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "private${count.index + 1}"
      Type = "private"
    }
  )
}
