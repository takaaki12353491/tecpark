resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "main"
    }
  )
}
