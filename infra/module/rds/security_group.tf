resource "aws_security_group" "datastore" {
  name        = "datastore"
  description = "database role security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    security_groups = [
      var.api_security_group_id,
      var.bastion_security_group_id
    ]
  }

  tags = {
    Name = "datastore"
  }
}
