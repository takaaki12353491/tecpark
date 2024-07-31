resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "public"
      Type = "public"
    }
  )
}

resource "aws_route_table_association" "public_link_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_link_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_1c.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "private"
      Type = "private"
    }
  )
}

resource "aws_route_table_association" "private_link_1a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_link_1c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnet_1c.id
}
