data "aws_iam_policy_document" "ec2_assume_iam" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_service_access" {
  name               = "ec2-service-access"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_iam.json

  tags = merge(
    local.common_tags,
    {
      Name = "ec2-service-access"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_access" {
  role       = aws_iam_role.ec2_service_access.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_grant_service_access" {
  name = "ec2-assume-role-profile"
  role = aws_iam_role.ec2_service_access.name

  tags = merge(
    local.common_tags,
    {
      Name = "ec2-assume-role-profile"
    }
  )
}

resource "aws_instance" "bastion_server" {
  ami           = "ami-0d03c6e00d5732e28" # Amazon Linux 2023
  instance_type = "t2.micro"

  iam_instance_profile   = aws_iam_instance_profile.ec2_grant_service_access.name
  subnet_id              = var.public_subnet_1a_id
  vpc_security_group_ids = [var.security_group_bastion_id]

  tags = merge(
    local.common_tags,
    {
      Name = "bastion-server"
    }
  )
}
resource "aws_cloudwatch_log_group" "ssm_log_group" {
  name              = "ssm-log-group"
  retention_in_days = 7

  tags = merge(
    local.common_tags,
    {
      Name = "ssm-log-group"
    }
  )
}

resource "aws_ssm_document" "ssm_logging" {
  name          = "ssm-logging"
  document_type = "Session"

  content = jsonencode({
    schemaVersion = "1.0"
    description   = "Enable Session Manager logging to CloudWatch Logs"
    sessionType   = "Standard_Stream"
    inputs = {
      cloudWatchLogGroupName      = aws_cloudwatch_log_group.ssm_log_group.name
      cloudWatchEncryptionEnabled = false
    }
  })

  tags = merge(
    local.common_tags,
    {
      Name = "ssm-logging"
    }
  )
}
