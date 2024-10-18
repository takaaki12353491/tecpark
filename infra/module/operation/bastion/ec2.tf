resource "aws_instance" "bastion" {
  ami           = "ami-0d03c6e00d5732e28" # Amazon Linux 2023
  instance_type = "t2.micro"

  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  subnet_id              = var.private_subnet_ids[var.azs[0]]
  vpc_security_group_ids = [aws_security_group.bastion.id]

  user_data = file("ec2_user_data.sh")
}

