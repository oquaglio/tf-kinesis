variable "stack_name" {
  type = object({
    hyphenated  = string
    underscored = string
  })

  default = {
    hyphenated  = "tf-kinesis"
    underscored = "tf_kinesis"
  }
}

variable "aws_context" {
  type = object({
    profile     = string
    region      = string
    region_code = string # short code for region
  })
}

variable "owner" {
  description = "A group email address to be used in tags"
  type        = string
  default     = "test@email.com"
}

variable "environment" {
  description = "Used for seperating terraform backends and naming items"
  type        = string
  default     = "dev"
}

variable "custom_tags" {
  type = map(string)
}