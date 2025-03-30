provider "aws" {
  region = "eu-west-2"
}

data "aws_caller_identity" "current" {}

module "state-s3" {
  source = "../modules/state-s3"
}

module "terraform_cicd_user" {
  source               = "../modules/iam/users/terraform-cicd"
  state_s3_bucket_name = module.state-s3.state_s3_bucket_name
}