resource "aws_subnet" "public" {
  for_each = local.public_cidrs

  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-${each.key}"
      Type = "public"
    }
  )
}

resource "aws_subnet" "private" {
  for_each = local.private_cidrs

  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "private-${each.key}"
      Type = "private"
    }
  )
}
