resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.all_cidr
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

# ALBに設定するサブネットは２つともパブリックサブネットでないといけない
resource "aws_route_table_association" "dummy_subnet" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.dummy.id
}

resource "aws_route_table" "private" {
  for_each = aws_nat_gateway.public

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = local.all_cidr
    nat_gateway_id = each.value.id
  }
}

resource "aws_route_table_association" "private_subnet" {
  for_each = aws_subnet.private

  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = each.value.id
}
