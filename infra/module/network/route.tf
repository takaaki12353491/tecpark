resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.all_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "public"
      Type = "public"
    }
  )
}

resource "aws_route_table_association" "public_subnet" {
  count = length(aws_subnet.public)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
  count  = length(aws_nat_gateway.public)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = local.all_cidr
    nat_gateway_id = aws_nat_gateway.public[count.index].id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "private${count.index + 1}"
      Type = "private"
    }
  )
}

resource "aws_route_table_association" "private_subnet" {
  count = length(aws_subnet.private)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}
