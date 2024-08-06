resource "aws_iam_role" "bastion" {
  name               = "bastion"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  ]

  tags = {
    Name = "bastion"
  }
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = aws_iam_role.bastion.name

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0d03c6e00d5732e28" # Amazon Linux 2023
  instance_type = "t2.micro"

  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_bastion_id]

  user_data = file("ec2_user_data.sh")

  tags = {
    Name = "bastion"
  }
}

