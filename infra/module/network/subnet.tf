resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-1a"
      Type = "public"
    }
  )
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-1c"
      Type = "public"
    }
  )
}

resource "aws_subnet" "private_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "private-1a"
      Type = "private"
    }
  )
}

resource "aws_subnet" "private_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "private-1c"
      Type = "private"
    }
  )
}
