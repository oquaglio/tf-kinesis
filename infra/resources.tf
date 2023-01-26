resource "aws_kinesis_stream" "this" {
  name             = var.stack_name.hyphenated
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = local.stack_context.tags
}