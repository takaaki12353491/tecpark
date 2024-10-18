resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds role security group"
  vpc_id      = var.main_vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    # security_groupsではなくcidr_blocksを指定することで依存関係を減らし、新しいリソースが追加されても対応できるようにする。
    cidr_blocks = values(var.private_cidrs)
  }
}
