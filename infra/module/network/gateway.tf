resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "main"
    }
  )
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public

  tags = merge(
    local.common_tags,
    {
      Name = "nat-${each.key}"
    }
  )
}

resource "aws_nat_gateway" "public" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(
    local.common_tags,
    {
      Name = "public-${each.key}"
    }
  )
}
