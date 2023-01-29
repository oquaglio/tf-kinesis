/**********************************************************************************
*
* Data Stream
*
**********************************************************************************/
resource "aws_kinesis_stream" "this" {
  name             = "${var.stack_name.hyphenated}-data-stream-${var.aws_context.region_code}-${var.environment}"
  shard_count      = 2
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

/**********************************************************************************
*
* Firehose
*
**********************************************************************************/
resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = "${var.stack_name.hyphenated}-firehose-stream-${var.aws_context.region_code}-${var.environment}"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.this.arn
    // TODO: this role needs to allow access to the source kinesis stream
    role_arn = aws_iam_role.firehose_role.arn
  }

  s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
    // 10 MB before sending to dest
    buffer_size = 10
    // 400s before sending to dest
    buffer_interval    = 400
    compression_format = "ZIP"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.stack_name.hyphenated}-s3-${var.aws_context.region_code}-${var.environment}"
  force_destroy = true
  tags          = local.stack_context.tags
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}