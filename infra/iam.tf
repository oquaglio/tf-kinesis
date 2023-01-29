resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  managed_policy_arns = [aws_iam_policy.kinesis_policy.arn]

  tags = local.stack_context.tags
}


resource "aws_iam_policy" "kinesis_policy" {
  name = "${var.stack_name.hyphenated}-policy-${var.aws_context.region_code}-${var.environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["kinesis:DescribeStream"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = local.stack_context.tags
}