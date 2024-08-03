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
  tags = merge(
    local.common_tags,
    {
      Name = "nat"
    }
  )
}

resource "aws_nat_gateway" "public_1a" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1a.id

  tags = merge(
    local.common_tags,
    {
      Name = "public_1a"
    }
  )
}
