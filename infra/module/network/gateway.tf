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
  count = length(local.availability_zones)

  tags = merge(
    local.common_tags,
    {
      Name = "nat${count.index + 1}"
    }
  )
}

resource "aws_nat_gateway" "public" {
  count = length(local.availability_zones)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    local.common_tags,
    {
      Name = "public${count.index + 1}"
    }
  )
}
