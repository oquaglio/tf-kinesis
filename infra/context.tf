locals {

  stack_context = {
    stack_name  = var.stack_name.hyphenated
    environment = var.environment
    owner       = var.owner
    tags        = local.all_tags
  }

  tags = {
    stack_name  = "${var.stack_name.hyphenated}"
    environment = "${var.environment}"
    repository  = "https://github.com/oquaglio/tf-kinesis"
    created_by  = "terraform"
    owner       = "${var.owner}"
    workspace   = terraform.workspace
  }

  all_tags = merge(local.tags, var.custom_tags)
}
