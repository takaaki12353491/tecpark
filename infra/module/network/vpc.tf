resource "aws_vpc" "main" {
  cidr_block                       = local.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = merge(
    local.common_tags,
    {
      Name = "main"
    }
  )
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [for rt in aws_route_table.private : rt.id]

  tags = merge(
    local.common_tags,
    {
      Name = "s3"
    }
  )
}

# トラフィックが多いのでエンドポイントで料金を抑える
resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.main.id
  service_name        = data.aws_vpc_endpoint_service.logs.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]
  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = "logs"
    }
  )
}
