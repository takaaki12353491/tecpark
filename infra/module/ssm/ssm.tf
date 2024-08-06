resource "aws_cloudwatch_log_group" "ssm_bastion" {
  name              = "/ssm/bastion"
  retention_in_days = 7

  tags = merge(
    local.common_tags,
    {
      Name = "ssm-bastion"
    }
  )
}

resource "aws_ssm_document" "logging" {
  name            = "logging"
  document_type   = "Session"
  document_format = "JSON"

  content = jsonencode({
    schemaVersion = "1.0"
    description   = "Enable Session Manager logging to CloudWatch Logs"
    sessionType   = "Standard_Stream"
    inputs = {
      cloudWatchLogGroupName      = "${aws_cloudwatch_log_group.ssm_bastion.name}"
      cloudWatchEncryptionEnabled = false
    }
  })

  tags = merge(
    local.common_tags,
    {
      Name = "logging"
    }
  )
}
