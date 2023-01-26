provider "aws" {
  profile = var.aws_context["profile"]
  region  = var.aws_context["region"]
}

provider "random" {}
