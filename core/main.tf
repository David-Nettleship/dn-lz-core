provider "aws" {
  region = "eu-west-2"
}

data "aws_caller_identity" "current" {}

module "state-s3" {
  source = "../state-s3"
}