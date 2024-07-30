data "aws_iam_policy_document" "ec2_assume_role_pd" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_assume_role" {
  name               = "${var.project}-${var.env}-ec2-assume-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_pd.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-ec2-assume-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy_attachment" {
  role       = aws_iam_role.ec2_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_assume_role_profile" {
  name = "${var.project}-${var.env}-ec2-assume-role-profile"
  role = aws_iam_role.ec2_assume_role.name

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-ec2-assume-role-profile"
    }
  )
}

resource "aws_instance" "bastion_server" {
  ami           = "ami-0d03c6e00d5732e28" # Amazon Linux 2023
  instance_type = "t2.micro"

  iam_instance_profile   = aws_iam_instance_profile.ec2_assume_role_profile.name
  vpc_security_group_ids = [var.app_sg_id]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.env}-bastion-server"
    }
  )
}
